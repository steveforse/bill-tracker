# frozen_string_literal: true

# Payment model
class Payment < ApplicationRecord
  # Relations
  belongs_to :schedule

  # Validations
  validates :schedule_id, presence: true
  validates :date, date: true, presence: true
  validates :due_date, date: true, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
