require "application_system_test_case"

class SchedulesTest < ApplicationSystemTestCase
  setup do
    @schedule = schedules(:one)
  end

  test "visiting the index" do
    visit schedules_url
    assert_selector "h1", text: "Schedules"
  end

  test "creating a Schedule" do
    visit schedules_url
    click_on "New Schedule"

    check "Autopay" if @schedule.autopay
    fill_in "Due date", with: @schedule.due_date
    fill_in "End date", with: @schedule.end_date
    fill_in "Frequency", with: @schedule.frequency
    fill_in "Minimum payment", with: @schedule.minimum_payment
    fill_in "Payee", with: @schedule.payee_id
    fill_in "Start date", with: @schedule.start_date
    click_on "Create Schedule"

    assert_text "Schedule was successfully created"
    click_on "Back"
  end

  test "updating a Schedule" do
    visit schedules_url
    click_on "Edit", match: :first

    check "Autopay" if @schedule.autopay
    fill_in "Due date", with: @schedule.due_date
    fill_in "End date", with: @schedule.end_date
    fill_in "Frequency", with: @schedule.frequency
    fill_in "Minimum payment", with: @schedule.minimum_payment
    fill_in "Payee", with: @schedule.payee_id
    fill_in "Start date", with: @schedule.start_date
    click_on "Update Schedule"

    assert_text "Schedule was successfully updated"
    click_on "Back"
  end

  test "destroying a Schedule" do
    visit schedules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Schedule was successfully destroyed"
  end
end
