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
  validate :due_date_between_schedule_start_and_end_dates

  def due_date_between_schedule_start_and_end_dates
    if (due_date.present? && due_date < schedule.start_date) ||
       (schedule.end_date.present? && due_date > schedule.end_date)
      errors.add(:due_date, 'must be between schedule start and end dates')
    end
  end
end
