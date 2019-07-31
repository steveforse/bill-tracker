# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payees', type: :system do
  before do
    sign_in create(:user)
    create(:schedule)
  end

  let(:payee) { Payee.first }

  describe 'index page', js: true do
    before { visit '/payees' }

    it 'visits new payee page after clicking "New Payee" button' do
      click_link 'New Payee'
      expect(page).to have_current_path(new_payee_path)
    end

    it 'visits show page after clicking "Details" button' do
      click_link 'Details'
      expect(page).to have_current_path(payee_path(payee))
    end

    it 'renders confirmation modal after clicking "Delete"' do
      click_link 'Delete'
      assert_selector '.modal-content' do
        assert_selector 'h5', text: 'Are you sure?'
        assert_selector '.modal-body', text: 'Deleting this payee will also permanently delete ' \
          'all associated schedules with their payment histories. Are you sure you want to ' \
          'permanently delete this payee?'
      end
    end

    it 'allows deletes record after confirming at the modal' do
      assert_selector '.card-body .h5', count: 0
      click_link 'Delete'
      click_button 'Delete Payee'
      assert_selector '.card-body .h5', text: 'Create a payee to get started'
    end

    it 'does not delete record after confirming at the modal' do
      assert_selector '.card-body .h5', count: 0
      click_link 'Delete'
      click_button 'Cancel'
      assert_selector '.card-body .h5', count: 0
    end

    it 'sorts the columns from header links to ascend' do
      %w[name nickname website phone_number].each do |column|
        click_link column.titleize
        expect(page).to have_current_path(payees_path(sort: "#{column}_asc"))
      end
    end
    it 'sorts the columns from header links to descend' do
      %w[name nickname website phone_number].each do |column|
        click_link column.titleize
        sleep(0.1)
        click_link column.titleize
        expect(page).to have_current_path(payees_path(sort: "#{column}_desc"))
      end
    end
  end

  describe 'show page', js: true do
    let(:schedule) { payee.schedules.first }

    before { visit "/payees/#{payee.id}" }

    it 'visits payees edit page after clicking "Edit Payee" button' do
      click_link 'Edit Payee'
      expect(page).to have_current_path(edit_payee_path(payee))
    end

    it 'returns to payees index after deleting' do
      click_link 'Delete Payee'
      click_button 'Delete Payee'
      expect(page).to have_current_path(payees_path)
    end

    it 'visits payees index after clicking "Back to Payees List" button' do
      click_link 'Back to Payees List'
      expect(page).to have_current_path(payees_path)
    end

    it 'vists new schedule page after clicking "New Schedule" button' do
      click_link 'New Schedule'
      expect(page).to have_current_path(new_payee_schedule_path(payee))
    end

    it 'visits schedules show page after clicking "Details" button' do
      click_link 'Details'
      expect(page).to have_current_path(schedule_path(schedule))
    end
  end

  describe 'edit page' do
    before { visit "/payees/#{payee.id}/edit" }

    let(:name) { 'A Sample Name' }
    let(:nickname) { 'A Nickname' }
    let(:website) { 'http://website' }
    let(:phone_number) { '123-123-1234' }
    let(:description) { 'A short sample description' }
    let(:fields) { [name, nickname, website, phone_number, description] }

    it 'updates when valid values are given' do
      fill_in 'Name', with: name
      fill_in 'Nickname', with: nickname
      fill_in 'Website', with: website
      fill_in 'Phone Number', with: phone_number
      fill_in 'Description', with: description

      click_button 'Update Payee'

      fields.each do |field|
        expect(page).to have_content field
      end
    end

    it 'shows errors when invalid values are given' do
      fill_in 'Name', with: ''

      click_button 'Update Payee'

      expect(page).to have_content "Name can't be blank"
    end

    it 'resets form values when clicking "Reset Form" button' do
      fill_in 'Name', with: name
      fill_in 'Nickname', with: nickname
      fill_in 'Website', with: website
      fill_in 'Phone Number', with: phone_number
      fill_in 'Description', with: description

      click_button 'Reset Form'

      fields.each do |field|
        expect(page).not_to have_content field
      end
    end

    it 'returns to payee details when clicking "Back to Payee Details" button' do
      click_link 'Back to Payee Details'
      expect(page).to have_current_path(payee_path(payee))
    end
  end

  describe 'new payee page' do
    before { visit '/payees/new' }

    let(:name) { 'A Sample Name' }
    let(:nickname) { 'A Nickname' }
    let(:website) { 'http://website' }
    let(:phone_number) { '123-123-1234' }
    let(:description) { 'A short sample description' }
    let(:fields) { [name, nickname, website, phone_number, description] }

    it 'creates a new payee with valid values' do
      expect do
        fill_in 'Name', with: name
        fill_in 'Nickname', with: nickname
        fill_in 'Website', with: website
        fill_in 'Phone Number', with: phone_number
        fill_in 'Description', with: description
        click_button 'Create Payee'
      end.to change(Payee, :count).by(1)

      expect(page).to have_current_path(payee_path(Payee.last))

      fields.each do |field|
        expect(page).to have_content field
      end
    end

    it 'displays error message with invalid values' do
      expect do
        fill_in 'Name', with: ''
        click_button 'Create Payee'
      end.not_to change(Payee, :count)

      expect(page).to have_current_path(payees_path)
      expect(page).to have_content "Name can't be blank"
    end

    it 'resets form when clicking "Reset Form" button' do
      expect do
        fill_in 'Name', with: name
        fill_in 'Nickname', with: nickname
        fill_in 'Website', with: website
        fill_in 'Phone Number', with: phone_number
        fill_in 'Description', with: description
        click_button 'Reset Form'
      end.not_to change(Payee, :count)

      expect(page).to have_current_path(new_payee_path)

      fields.each do |field|
        expect(page).not_to have_content(field)
      end
    end

    it 'returns to payees list when clicking "Back to Payees List" button' do
      expect do
        fill_in 'Name', with: name
        fill_in 'Nickname', with: nickname
        fill_in 'Website', with: website
        fill_in 'Phone Number', with: phone_number
        fill_in 'Description', with: description
        click_link 'Back to Payees List'
      end.not_to change(Payee, :count)

      expect(page).to have_current_path(payees_path)

      fields.each do |field|
        expect(page).not_to have_content(field)
      end
    end
  end
end
