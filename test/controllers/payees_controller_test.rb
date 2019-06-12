require 'test_helper'

class PayeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payee = payees(:one)
  end

  test "should get index" do
    get payees_url
    assert_response :success
  end

  test "should get new" do
    get new_payee_url
    assert_response :success
  end

  test "should create payee" do
    assert_difference('Payee.count') do
      post payees_url, params: { payee: { alternative_name: @payee.alternative_name, description: @payee.description, name: @payee.name, phone_number: @payee.phone_number, website: @payee.website } }
    end

    assert_redirected_to payee_url(Payee.last)
  end

  test "should show payee" do
    get payee_url(@payee)
    assert_response :success
  end

  test "should get edit" do
    get edit_payee_url(@payee)
    assert_response :success
  end

  test "should update payee" do
    patch payee_url(@payee), params: { payee: { alternative_name: @payee.alternative_name, description: @payee.description, name: @payee.name, phone_number: @payee.phone_number, website: @payee.website } }
    assert_redirected_to payee_url(@payee)
  end

  test "should destroy payee" do
    assert_difference('Payee.count', -1) do
      delete payee_url(@payee)
    end

    assert_redirected_to payees_url
  end
end
