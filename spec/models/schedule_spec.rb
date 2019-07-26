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
      it "generates correct rrule for #{frequency} frequency" do
        schedule.frequency = frequency
        expect(schedule.rrule_string)
          .to include("DTSTART=#{schedule.start_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("DTEND=#{schedule.end_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("FREQ=#{Schedule.frequencies[schedule.frequency][:frequency].upcase}")
          .and include("INTERVAL=#{Schedule.frequencies[schedule.frequency][:interval]}")
      end

      it 'skips end_date if not set' do
        schedule.frequency = frequency
        schedule.end_date = nil
        expect(schedule.rrule_string).not_to include("DTEND=")
      end
    end

    it 'generates correct rrule for semimonthly' do
      schedule.frequency = 'semimonthly'
      expect(schedule.rrule_string)
          .to include("DTSTART=#{schedule.start_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("DTEND=#{schedule.end_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("FREQ=#{Schedule.frequencies[schedule.frequency][:frequency].upcase}")
          .and include("INTERVAL=#{Schedule.frequencies[schedule.frequency][:interval]}")
          .and include("BYMONTHDAY=#{schedule.start_date.day},")
    end

    it 'generates correct rrule for semiannually' do
      schedule.frequency = 'semiannually'
      expect(schedule.rrule_string)
          .to include("DTSTART=#{schedule.start_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("DTEND=#{schedule.end_date.strftime('%Y%m%dT%H%M%S')}")
          .and include("FREQ=#{Schedule.frequencies[schedule.frequency][:frequency].upcase}")
          .and include("INTERVAL=#{Schedule.frequencies[schedule.frequency][:interval]}")
          .and include("BYMONTH=#{schedule.start_date.month},")
    end
  end
end
