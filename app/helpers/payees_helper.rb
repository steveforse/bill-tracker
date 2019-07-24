# frozen_string_literal: true

# These helpers used in views for payees
module PayeesHelper
  def payee_delete_modal_params
    { confirm: 'Deleting this payee will also permanently delete all associated schedules with ' \
               'their payment histories. Are you sure you want to permanently delete this payee?',
      commit: 'Delete Payee' }
  end
end
