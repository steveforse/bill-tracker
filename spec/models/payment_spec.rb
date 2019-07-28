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

  describe 'custom validators' do
    let(:payment) { create(:payment) }
    describe 'due_date_after_start_date'  do
      it 'cannot have due_date before start_date' do
        payment.due_date = payment.schedule.start_date - 1.month
        payment.valid?
        expect(payment.errors.messages[:due_date]).to \
          include('must be after schedule start date')
      end
    end

    describe 'due_date_before_end_date'  do
      it 'cannot have due_date after end_date' do
        payment.due_date = payment.schedule.end_date + 1.month
        payment.valid?
        expect(payment.errors.messages[:due_date]).to \
          include('must be before schedule end date')
      end
    end

    describe 'due_date_must_be_valid_recurrence_date' do
      it 'cannot have a due_date unless it is a recurrence date' do
        payment.schedule.frequency = 'weekly'
        payment.due_date += 1.day
        payment.valid?
        expect(payment.errors.messages[:due_date]).to \
          include('must be on a valid schedule recurrence date')
      end
    end
  end
end
