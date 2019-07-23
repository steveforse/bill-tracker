# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:schedule) }
  end

  describe 'validations' do
    subject(:model) { described_class.new }

    # Schedule ID
    it { is_expected.to validate_presence_of(:schedule_id) }

    # Date
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_date_of(:date) }

    # Due Date
    it { is_expected.to validate_presence_of(:due_date) }
    it { is_expected.to validate_date_of(:due_date) }

    # Amount
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end
end
