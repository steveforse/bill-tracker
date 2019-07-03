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
    it { is_expected.to_not allow_value('2020-12-29').for(:start_date) }

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

    # Association exists
    it { is_expected.to allow_value(create(:payee).id).for(:payee_id) }
    it { is_expected.to_not allow_value(9999).for(:payee_id) }
  end
end
