class Payee < ApplicationRecord
  strip_attributes

  # Relations
  has_many :schedules

  # Validations
  validates :name, presence: true, uniqueness: true, allow_blank: false, allow_nil: false
end
