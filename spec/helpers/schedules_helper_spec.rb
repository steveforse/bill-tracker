# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchedulesHelper, type: :helper do
  describe 'grouped_frequencies' do
    it { expect(helper.grouped_frequencies.count).to eq(3) }

    describe 'Weekly' do
      let(:test_case) { helper.grouped_frequencies[0] }

      it { expect(test_case[0]).to eq('Weekly') }
      it { expect(test_case[1].count).to eq(3) }
    end

    describe 'Monthly' do
      let(:test_case) { helper.grouped_frequencies[1] }

      it { expect(test_case[0]).to eq('Monthly') }
      it { expect(test_case[1].count).to eq(4) }
    end

    describe 'Annually' do
      let(:test_case) { helper.grouped_frequencies[2] }

      it { expect(test_case[0]).to eq('Annually') }
      it { expect(test_case[1].count).to eq(2) }
    end
  end
end
