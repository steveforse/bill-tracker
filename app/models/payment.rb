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

  def due_date_must_be_valid_recurrence_date
    return if !schedule || !due_date
    return if schedule.recurrence_date? due_date

    errors.add(:due_date, 'must be on a valid schedule recurrence date')
  end
end
