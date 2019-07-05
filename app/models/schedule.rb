# frozen_string_literal: true

# Model for schedules
class Schedule < ApplicationRecord
  strip_attributes

  # Relations
  belongs_to :payee
  has_many :payments, dependent: :destroy

  # Validations
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
      'weekly' => 'Once every week',
      'biweekly' => 'Once every two weeks',
      'quadweekly' => 'Once every three weeks',

      # Month-based frequencies
      'monthly' => 'Once every month',
      'bimonthly' => 'Once every two months',
      'semimonthly' => 'Twice every month',
      'trimonthly' => 'Quarterly (once every four months)',

      # Year-based frequencies
      'annually' => 'Once every year',
      'semiannually' => 'Twice every year'
    }.freeze
  end

  private

  def associated_payee_exists
    errors.add(:payee_id, 'must be an existing payee') unless Payee.exists? payee_id
  end
end
