# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :system do
  before { sign_in create(:user) }

  let(:payee) { create(:payee) }

  describe 'new page', js: true do
    before { visit "/payees/#{payee.id}/schedules/new" }

    it 'creates a new schedule with valid values' do
      attributes = attributes_for(:schedule)

      expect do
        fill_in 'Name', with: attributes[:name]
        fill_in 'Start Date', with: attributes[:start_date]
        fill_in 'End Date', with: attributes[:end_date]
        select Schedule.frequencies[attributes[:frequency]][:description], from: 'Frequency'
        fill_in 'Minimum Payment', with: '100.00'
        find('.toggle.btn').click
        click_button 'Create Schedule'
      end.to change(Schedule, :count).by(1)

      expect(page).to have_current_path(payee_path(payee.id))

      expect(page).to have_content(attributes[:name])
      expect(page).to have_content(attributes[:start_date])
      expect(page).to have_content(attributes[:end_date])
      expect(page).to have_content(Schedule.frequencies[attributes[:frequency]][:description])
      expect(page).to have_content('$100.00')
      expect(page).to have_content('Enabled')
    end

    it 'shows errors when submitted with invalid values' do
      expect do
        fill_in 'Start Date', with: ''
        click_button 'Create Schedule'
      end.not_to change(Schedule, :count)

      expect(page).to have_content("Start Date can't be blank")
      expect(page).to have_content('Frequency must be from dropdown list')
    end

    it 'returns to payee details when clicking "Back to Payee" button' do
      click_link 'Back to Payee'
      expect(page).to have_current_path(payee_path(payee))
    end

    it 'resets the form after clicking "Reset Form" button' do
      attributes = attributes_for(:schedule)

      expect do
        fill_in 'Name', with: attributes[:name]
        fill_in 'Start Date', with: attributes[:start_date]
        fill_in 'End Date', with: attributes[:end_date]
        select Schedule.frequencies[attributes[:frequency]][:description], from: 'Frequency'
        fill_in 'Minimum Payment', with: '100.00'
        find('.toggle.btn').click
        click_button 'Reset Form'
      end.not_to change(Schedule, :count)

      expect(page).not_to have_content(attributes[:name])
      expect(page).not_to have_content(attributes[:start_date])
      expect(page).not_to have_content(attributes[:end_date])
      expect(page).not_to have_content('100.00')
    end
  end

  describe 'edit page', js: true do
    before do
      schedule = create(:schedule, payee: payee)
      visit "/schedules/#{schedule.id}/edit"
    end

    let(:schedule) { payee.schedules.first }

    it 'allows modifying schedule with valid values' do
      attributes = attributes_for(:schedule)

      expect do
        fill_in 'Name', with: attributes[:name]
        fill_in 'Start Date', with: attributes[:start_date]
        fill_in 'End Date', with: attributes[:end_date]
        select Schedule.frequencies[attributes[:frequency]][:description], from: 'Frequency'
        fill_in 'Minimum Payment', with: '100.00'
        click_button 'Update Schedule'
      end.not_to change(Schedule, :count)

      expect(page).to have_current_path(schedule_path(schedule))

      expect(page).to have_content(attributes[:name])
      expect(page).to have_content(attributes[:start_date])
      expect(page).to have_content(attributes[:end_date])
      expect(page).to have_content(Schedule.frequencies[attributes[:frequency]][:description])
      expect(page).to have_content('$100.00')
    end

    it 'displays an error message for invalid values' do
      expect do
        fill_in 'Start Date', with: ''
        click_button 'Update Schedule'
      end.not_to change(Schedule, :count)

      expect(page).to have_content("Start Date can't be blank")
    end

    it 'returns to schedule details when clicking "Back to Schedule Details" button' do
      click_link 'Back to Schedule Details'
      expect(page).to have_current_path(schedule_path(schedule))
    end

    it 'resets the form after clicking "Reset Form" button' do
      attributes = attributes_for(:schedule)

      expect do
        fill_in 'Start Date', with: attributes[:start_date]
        fill_in 'End Date', with: attributes[:end_date]
        select Schedule.frequencies[attributes[:frequency]][:description], from: 'Frequency'
        fill_in 'Minimum Payment', with: '100.00'
        find('.toggle.btn').click
        click_button 'Reset Form'
      end.not_to change(Schedule, :count)

      expect(page).not_to have_content(attributes[:name])
      expect(page).not_to have_content(attributes[:start_date])
      expect(page).not_to have_content(attributes[:end_date])
      expect(page).not_to have_content('100.00')
    end
  end
end
