# frozen_string_literal: true

# Model for payees
class Payee < ApplicationRecord
  strip_attributes

  # Relations
  has_many :schedules, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true, allow_blank: false
end
