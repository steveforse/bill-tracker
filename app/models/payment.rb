# frozen_string_literal: true

# Payment model
class Payment < ApplicationRecord
  strip_attributes

  # Relations
  belongs_to :schedule

  # Validations
  validates :schedule_id, presence: true
  validates :date, date: true, presence: true
  validates :due_date, date: true, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # Custom validator
  validate :due_date_after_start_date
  validate :due_date_before_end_date
  validate :due_date_must_be_valid_recurrence_date

  def due_date_after_start_date
    return if !schedule || !due_date || due_date >= schedule.start_date

    errors.add(:due_date, 'must be after schedule start date')
  end

  def due_date_before_end_date
    return if !schedule || !due_date || schedule.end_date.blank? || due_date <= schedule.end_date

    errors.add(:due_date, 'must be before schedule end date')
  end

  # rubocop: disable Metrics/AbcSize
  def due_date_must_be_valid_recurrence_date
    return if !schedule || !due_date

    # RRule seems to have a bug with parsing UTC times for dtstart
    start_date = schedule.start_date
    dtstart = [start_date.year, start_date.month, start_date.day]
    rrule = RRule.parse(schedule.rrule_string, dtstart: Time.zone.local(*dtstart))
    return if rrule.between((due_date - 1.day).to_datetime, (due_date + 1.day).to_datetime)
                   .include? due_date

    errors.add(:due_date, 'must be on a valid schedule recurrence date')
  end
  # rubocop: enable Metrics/AbcSize
end
