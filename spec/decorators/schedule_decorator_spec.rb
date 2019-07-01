# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduleDecorator do
  let(:schedule) do
    build(:schedule).decorate
  end

  describe '#autopay' do
    it 'renders autopay false as Disabled' do
      schedule.autopay = false
      expect(schedule.autopay).to eq('Disabled')
    end

    it 'renders autopay true as Enabled' do
      schedule.autopay = true
      expect(schedule.autopay).to eq('Enabled')
    end
  end

  describe '#minimum_payment' do
    it 'renders minimum payment as currency' do
      schedule.minimum_payment = 42.3
      expect(schedule.minimum_payment).to eq('$42.30')
    end
  end

  describe '#frequency' do
    it 'renders frequency as long description from model' do
      schedule.frequency = 'weekly'
      expect(schedule.frequency).to eq(Schedule.frequencies['weekly'])
    end
  end
end
