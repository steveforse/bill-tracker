# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:payee) }
  end

  describe 'validations' do
    subject(:model) { described_class.new }

    # Start date
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_date_of(:start_date) }
    it { is_expected.to allow_value('2020-12-28').for(:start_date) }
    it { is_expected.not_to allow_value('2020-12-29').for(:start_date) }

    # End date
    it { is_expected.to validate_date_of(:end_date).after(:start_date).allow_blank }

    # Payee_id
    it { is_expected.to validate_presence_of(:payee_id) }
    it { is_expected.to validate_numericality_of(:payee_id).only_integer }

    # Frequency
    it 'uses frequency values from model' do
      expect(model).to validate_inclusion_of(:frequency)
        .in_array(Schedule.frequencies.keys)
        .with_message('must be from dropdown list')
    end
  end

  describe 'custom validators' do
    let(:schedule) { create(:schedule) }

    describe '#autopay_requires_minimum_payment' do
      it 'does not require minimum payment if autopay is not set' do
        schedule.autopay = false
        schedule.minimum_payment = nil
        expect(schedule.valid?).to be true
      end

      it 'require minimum payment if autopay is set' do
        schedule.autopay = true
        schedule.minimum_payment = nil
        schedule.valid?
        expect(schedule.errors.messages[:autopay]).to \
          include('requires a value for minimum payment')
      end
    end

    describe '#cannot_modify_start_date_when_payments_exist' do
      it 'can have start_date modified if there are no payments' do
        schedule.payments = []
        schedule.start_date = schedule.start_date + 1.day
        expect(schedule.valid?).to be true
      end

      it 'cannot have start_date modified if there are  payments' do
        schedule.payments << create(:payment, schedule: schedule)
        schedule.start_date = schedule.start_date + 1.day
        schedule.valid?
        expect(schedule.errors.messages[:start_date]).to \
          include('cannot be changed if payments exist')
      end
    end

    describe '#end_date_must_be_after_last_payment' do
      it 'cannot have end_date after last payment' do
        payment = create(:payment, due_date: (schedule.start_date + 1.month), schedule: schedule)
        schedule.end_date = payment.due_date - 1.day
        schedule.valid?
        expect(schedule.errors.messages[:end_date]).to \
          include('must be after last payment due date')
      end
    end
  end

  describe 'self.frequencies' do
    %w[weekly biweekly quadweekly monthly bimonthly semimonthly trimonthly
       annually semiannually].each do |frequency|
      it { expect(described_class.frequencies).to include(frequency) }
      it "has correct attributes for #{frequency} frequency" do
        expect(described_class.frequencies[frequency]).to include(:description)
          .and include(:frequency)
          .and include(:interval)
      end
    end
  end

  describe '#rrule_string' do
    let(:schedule) do
      Schedule.new(
        name: 'example',
        start_date: Time.zone.today,
        end_date: Time.zone.tomorrow
      )
    end

    %w[weekly biweekly quadweekly monthly bimonthly trimonthly annually].each do |frequency|
      # rubocop: disable RSpec/ExampleLength
      it "generates correct rrule for #{frequency} frequency" do
        schedule.frequency = frequency
        expect(schedule.rrule_string)
          .to include("DTSTART=#{schedule.start_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("UNTIL=#{schedule.end_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("FREQ=#{Schedule.frequencies[schedule.frequency][:frequency].upcase}")
          .and include("INTERVAL=#{Schedule.frequencies[schedule.frequency][:interval]}")
      end
      # rubocop: enable RSpec/ExampleLength

      it 'skips end_date if not set' do
        schedule.frequency = frequency
        schedule.end_date = nil
        expect(schedule.rrule_string).not_to include('UNTIL=')
      end
    end

    # rubocop: disable RSpec/ExampleLength
    it 'generates correct rrule for semimonthly' do
      schedule.frequency = 'semimonthly'
      expect(schedule.rrule_string)
        .to include("DTSTART=#{schedule.start_date.strftime('%Y%m%dT%H%M%S')}")
        .and include("UNTIL=#{schedule.end_date.strftime('%Y%m%dT%H%M%S')}")
        .and include("FREQ=#{Schedule.frequencies[schedule.frequency][:frequency].upcase}")
        .and include("INTERVAL=#{Schedule.frequencies[schedule.frequency][:interval]}")
        .and include("BYMONTHDAY=#{schedule.start_date.day},")
    end

    it 'generates correct rrule for semiannually' do
      schedule.frequency = 'semiannually'
      expect(schedule.rrule_string)
        .to include("DTSTART=#{schedule.start_date.strftime('%Y%m%dT%H%M%S')}")
        .and include("UNTIL=#{schedule.end_date.strftime('%Y%m%dT%H%M%S')}")
        .and include("FREQ=#{Schedule.frequencies[schedule.frequency][:frequency].upcase}")
        .and include("INTERVAL=#{Schedule.frequencies[schedule.frequency][:interval]}")
        .and include("BYMONTH=#{schedule.start_date.month},")
    end
    # rubocop: enable RSpec/ExampleLength
  end
end
