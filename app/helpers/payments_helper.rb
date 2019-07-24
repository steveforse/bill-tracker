# frozen_string_literal: true

# These helpers used in views for payments
module PaymentsHelper
  def payment_delete_modal_params
    { confirm: 'Are you sure you want to permanently delete this payment?',
      commit: 'Delete Payment' }
  end
end
