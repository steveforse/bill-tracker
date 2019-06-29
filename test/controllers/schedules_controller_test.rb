require 'test_helper'

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule = schedules(:one)
    @payee = @schedule.payee
  end

  test "should get new" do
    get new_payee_schedule_url(@payee)
    assert_response :success
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post payee_schedules_url(@payee), params: { schedule: {
        start_date: '06/27/2007',
        end_date: '09/27/2020',
        frequency: 'weekly',
        minimum_payment: 45.23,
        autopay: true
      } }
    end

    assert_redirected_to payee_url(@payee)
  end

  test "should get edit" do
    get edit_schedule_url(@schedule)
    assert_response :success
  end

  test "should update schedule" do
    patch schedule_url(@schedule), params: { schedule: {
      start_date: @schedule.start_date,
      end_date: @schedule.end_date,
      frequency: @schedule.frequency,
      minimum_payment: @schedule.minimum_payment,
      autopay: @schedule.autopay
    } }
    assert_redirected_to payee_url(@payee)
  end

  test "should destroy schedule" do
    assert_difference('Schedule.count', -1) do
      delete schedule_url(@schedule)
    end

    assert_redirected_to payee_url(@payee)
  end
end
