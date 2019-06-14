class Payee < ApplicationRecord
  validates :name, presence: true, uniqueness: true, allow_blank: false
end
