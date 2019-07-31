# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :system do
  before { sign_in create(:user) }

  let(:schedule) { create(:schedule) }

  describe 'index' do
    before do
      create_list(:payment, 10, schedule: schedule)
      visit '/payments'
    end

    let(:payments) { Payment.all }

    it 'renders a card with payments' do
      assert_selector '.card-header .h4', text: 'Payments'
      assert_selector '.card-body' do
        assert_selector 'table.table' do
          assert_selector 'thead tr' do
            assert_selector 'th', count: 5
            assert_selector 'th a.rezort', text: 'Payee'
            assert_selector 'th a.rezort', text: 'Schedule'
            assert_selector 'th a.rezort', text: 'Date'
            assert_selector 'th a.rezort', text: 'Due Date'
            assert_selector 'th a.rezort', text: 'Amount'
          end
          assert_selector 'tbody' do
            payments.each do |payment|
              assert_selector 'tr' do
                assert_selector 'td:nth-of-type(1)', text: payment.schedule.payee.name
                assert_selector 'td:nth-of-type(2)', text: payment.schedule.name
                assert_selector 'td:nth-of-type(3)', text: payment.date.to_s
                assert_selector 'td:nth-of-type(4)', text: payment.due_date.to_s
                pay = payment
                assert_selector 'td:nth-of-type(5)', \
                                text: ActionController::Base.helpers.number_to_currency(pay.amount)
              end
            end
          end
        end
      end
    end
  end

  describe 'new page' do
    before { visit "/schedules/#{schedule.id}/payments/new" }

    it 'creates a new payment with valid values' do
      attributes = attributes_for(:payment, schedule: schedule)

      expect do
        fill_in 'Date', with: attributes[:date], match: :prefer_exact
        fill_in 'Due Date', with: attributes[:due_date]
        fill_in 'Amount', with: '100.00'
        fill_in 'Comment', with: attributes[:comment]
        click_button 'Create Payment'
      end.to change(Payment, :count).by(1)

      expect(page).to have_current_path(schedule_path(schedule.id))

      expect(page).to have_content(attributes[:date])
      expect(page).to have_content(attributes[:due_date])
      expect(page).to have_content('$100.00')
      expect(page).to have_content(attributes[:comment])
    end

    it 'shows errors when submitted with invalid values' do
      expect do
        fill_in 'Date', with: '', match: :prefer_exact
        fill_in 'Due Date', with: ''
        fill_in 'Amount', with: ''
        click_button 'Create Payment'
      end.not_to change(Payment, :count)

      expect(page).to have_content("Date can't be blank")
      expect(page).to have_content("Due Date can't be blank")
      expect(page).to have_content("Amount can't be blank")
    end

    it 'returns to schedule details when clicking "Back to Schedule" button' do
      click_link 'Back to Schedule'
      expect(page).to have_current_path(schedule_path(schedule))
    end

    it 'resets the form after clicking "Reset Form" button' do
      attributes = attributes_for(:payment, schedule: schedule)

      expect do
        fill_in 'Date', with: attributes[:date], match: :prefer_exact
        fill_in 'Due Date', with: attributes[:due_date]
        fill_in 'Amount', with: '100.00'
        click_button 'Reset Form'
      end.not_to change(Payment, :count)

      expect(page).not_to have_content(attributes[:date])
      expect(page).not_to have_content(attributes[:due_date])
      expect(page).not_to have_content('100.00')
    end
  end

  describe 'edit page' do
    let(:payment) { create(:payment) }

    before do
      visit "/payments/#{payment.id}/edit"
    end

    it 'updates a  payment with valid values' do
      attributes = attributes_for(:payment, schedule: payment.schedule)

      expect do
        fill_in 'Date', with: attributes[:date], match: :prefer_exact
        fill_in 'Due Date', with: attributes[:due_date]
        fill_in 'Amount', with: '100.00'
        fill_in 'Comment', with: attributes[:comment]
        click_button 'Update Payment'
      end.not_to change(Payment, :count)

      expect(page).to have_current_path(schedule_path(payment.schedule.id))

      expect(page).to have_content(attributes[:date])
      expect(page).to have_content(attributes[:due_date])
      expect(page).to have_content('$100.00')
      expect(page).to have_content(attributes[:comment])
    end

    it 'shows errors when submitted with invalid values' do
      expect do
        fill_in 'Date', with: '', match: :prefer_exact
        fill_in 'Due Date', with: ''
        fill_in 'Amount', with: ''
        click_button 'Update Payment'
      end.not_to change(Payment, :count)

      expect(page).to have_content("Date can't be blank")
      expect(page).to have_content("Due Date can't be blank")
      expect(page).to have_content("Amount can't be blank")
    end

    it 'returns to schedule details when clicking "Back to Schedule" button' do
      click_link 'Back to Schedule'
      expect(page).to have_current_path(schedule_path(payment.schedule))
    end

    it 'resets the form after clicking "Reset Form" button' do
      attributes = attributes_for(:payment, schedule: schedule)

      expect do
        fill_in 'Date', with: attributes[:date], match: :prefer_exact
        fill_in 'Due Date', with: attributes[:due_date]
        fill_in 'Amount', with: '100.00'
        click_button 'Reset Form'
      end.not_to change(Payment, :count)

      expect(page).not_to have_content(attributes[:date])
      expect(page).not_to have_content(attributes[:due_date])
      expect(page).not_to have_content('100.00')
    end
  end
end
