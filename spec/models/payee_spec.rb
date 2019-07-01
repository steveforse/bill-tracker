# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payee, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:schedules).dependent(:destroy) }
  end

  describe 'validations' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
