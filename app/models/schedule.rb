# frozen_string_literal: true

# Model for schedules
class Schedule < ApplicationRecord
  strip_attributes

  # Relations
  belongs_to :payee
  has_many :payments, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :start_date, presence: true, date: true,
                         format: { with: %r{\A\d*/(0[1-9]|1[0-9]|2[0-8])/\d*\z},
                                   message: 'must be on or before the 28th' }
  validates :end_date, date: { after: :start_date, allow_blank: true }
  validates :frequency, inclusion: { in: ->(_a) { frequencies.keys },
                                     message: 'must be from dropdown list' }
  validates :payee_id, presence: true, numericality: { only_integer: true }

  # Custom validators
  validate :cannot_modify_start_date_when_payments_exist
  validate :end_date_must_be_after_last_payment
  validate :autopay_requires_minimum_payment

  def autopay_requires_minimum_payment
    return if minimum_payment.present? || !autopay?

    errors.add(:autopay, 'requires a value for minimum payment')
  end

  def cannot_modify_start_date_when_payments_exist
    return if payments.empty? || start_date_was == start_date

    errors.add(:start_date, 'cannot be changed if payments exist')
  end

  def end_date_must_be_after_last_payment
    return if end_date.blank? || payments.empty?
    return if end_date > payments.order(due_date: :desc).first.due_date

    errors.add(:end_date, 'must be after last payment due date')
  end

  def self.frequencies
    { # Week-based frequencies
      'weekly' => { description: 'Once every week', frequency: 'weekly', interval: 1 },
      'biweekly' => { description: 'Once every two weeks', frequency: 'weekly', interval: 2 },
      'quadweekly' => { description: 'Once every three weeks', frequency: 'weekly', interval: 4 },

      # Month-based frequencies
      'monthly' => { description: 'Once every month', frequency: 'monthly', interval: 1 },
      'bimonthly' => { description: 'Once every two months', frequency: 'monthly', interval: 2 },
      'semimonthly' => { description: 'Twice every month', frequency: 'monthly', interval: 1 },
      'trimonthly' => { description: 'Quarterly (once every four months)', frequency: 'monthly',
                        interval: 3 },

      # Year-based frequencies
      'annually' => { description: 'Once every year', frequency: 'yearly', interval: 1 },
      'semiannually' => { description: 'Twice every year', frequency: 'yearly', interval: 1 }
    }.freeze
  end

  def rrule_string
    [rrule_dtstart, rrule_until, rrule_frequency, rrule_interval, rrule_semimonthly_bymonthdays,
     rrule_semiannually_bymonth].compact.join(';')
  end

  def generate_autopayments
    today = Time.zone.today
    payments = schedule.payments
    Schedule.each do |schedule|
      continue if !schedule.active? || payments.where(due_date: today).any? ||
                  !recurrence_date?(today)
      payments.create(due_date: today, date: today, amount: schedule.minimum_payemnt,
                      comment: 'Created by autopay')
    end
  end

  def recurrence_date?(date)
    rrule.between((date + 1.day).to_datetime, (date - 1.day).to_datetime).includes? date
  end

  def rrule
    dateparts = [dtstart.year, dtstart.month, dtstart.day]
    RRule.parse(schedule.rrule_string, dtstart: Time.zone.local(*dateparts))
  end

  def active?(date = nil)
    date = Time.zone.today if date.nil?
    date >= start_date && (end_date.nil? || date <= end_date)
  end

  private

  def rrule_dtstart
    "DTSTART=#{rrule_date_format(start_date)}"
  end

  def rrule_until
    return nil if end_date.blank?

    "UNTIL=#{rrule_date_format(end_date)}"
  end

  def rrule_date_format(date)
    date.strftime('%Y%m%dT%H%M%S')
  end

  def rrule_frequency
    "FREQ=#{Schedule.frequencies[frequency][:frequency].upcase}"
  end

  def rrule_interval
    "INTERVAL=#{Schedule.frequencies[frequency][:interval]}"
  end

  def rrule_semimonthly_bymonthdays
    return nil if frequency != 'semimonthly'

    start_day = start_date.day
    match_day = start_day > 14 ? start_day - 14 : start_day + 14
    "BYMONTHDAY=#{start_day},#{match_day}"
  end

  def rrule_semiannually_bymonth
    return nil if frequency != 'semiannually'

    start_month = start_date.month
    match_month = start_month > 6 ? start_month - 6 : start_month + 6
    "BYMONTH=#{start_month},#{match_month}"
  end
end
