# frozen_string_literal: true

require 'application_system_test_case'

class PayeesTest < ApplicationSystemTestCase
  setup do
    @payee = payees(:one)
  end

  test 'visiting the index' do
    visit payees_url
    assert_selector 'h1', text: 'Payees'
  end

  test 'creating a Payee' do
    visit payees_url
    click_on 'New Payee'

    fill_in 'Alternative name', with: @payee.alternative_name
    fill_in 'Description', with: @payee.description
    fill_in 'Name', with: @payee.name
    fill_in 'Phone number', with: @payee.phone_number
    fill_in 'Website', with: @payee.website
    click_on 'Create Payee'

    assert_text 'Payee was successfully created'
    click_on 'Back'
  end

  test 'updating a Payee' do
    visit payees_url
    click_on 'Edit', match: :first

    fill_in 'Alternative name', with: @payee.alternative_name
    fill_in 'Description', with: @payee.description
    fill_in 'Name', with: @payee.name
    fill_in 'Phone number', with: @payee.phone_number
    fill_in 'Website', with: @payee.website
    click_on 'Update Payee'

    assert_text 'Payee was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Payee' do
    visit payees_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Payee was successfully destroyed'
  end
end
