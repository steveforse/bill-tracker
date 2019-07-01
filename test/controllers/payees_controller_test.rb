# frozen_string_literal: true

require 'test_helper'

class PayeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payee = payees(:mercedes)
  end

  test 'should get index' do
    get payees_url
    assert_response :success
  end

  test 'should get new' do
    get new_payee_url
    assert_response :success
  end

  test 'should create payee' do
    assert_difference('Payee.count') do
      post payees_url, params: { payee: {
        name: 'New Payee',
        nickname: 'New Nickname',
        description: 'Some new description',
        phone_number: '555-555-5555',
        website: 'https://example.com'
      } }
    end

    assert_redirected_to payee_url(Payee.last)
  end

  test 'should show payee' do
    get payee_url(@payee)
    assert_response :success
  end

  test 'should get edit' do
    get edit_payee_url(@payee)
    assert_response :success
  end

  test 'should update payee' do
    patch payee_url(@payee), params: { payee: {
      nickname: @payee.nickname, description: @payee.description, name: @payee.name,
      phone_number: @payee.phone_number, website: @payee.website
    } }
    assert_redirected_to payee_url(@payee)
  end

  test 'should destroy payee' do
    assert_difference('Payee.count', -1) do
      delete payee_url(@payee)
    end

    assert_redirected_to payees_url
  end
end
