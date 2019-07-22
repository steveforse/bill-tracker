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
                         format: { with: %r{\d*/(0[1-9]|1[0-9]|2[0-8])/\d*},
                                   message: 'must be on or before the 28th' }
  validates :end_date, date: { after: :start_date, allow_blank: true }
  validates :frequency, inclusion: { in: ->(_a) { frequencies.keys },
                                     message: 'must be from dropdown list' }
  validates :payee_id, presence: true, numericality: { only_integer: true }
  validate :associated_payee_exists

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

  def due_dates(calendar_start_date, calendar_end_date)
    rule = RRule::Rule.new(rrule_string)
    rule.between(calendar_start_date, calendar_end_date)
  end

  def rrule_string
    [rrule_dtstart, rrule_dtend, rrule_frequency, rrule_interval, rrule_semimonthly_bymonthdays,
     rrule_semiannually_bymonth].compact.join(';')
  end

  private

  def rrule_dtstart
    "DTSTART=#{rrule_date_format(start_date)}"
  end

  def rrule_dtend
    return nil if end_date.blank?

    "DTEND=#{rrule_date_format(end_date)}"
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

  def associated_payee_exists
    errors.add(:payee_id, 'must be an existing payee') unless Payee.exists? payee_id
  end
end
