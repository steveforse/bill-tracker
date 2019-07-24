# frozen_string_literal: true

# These helpers used in views for schedules
module PayeesHelper
  def payee_delete_button_params
    { confirm: 'Deleting this payee will also delete all associated schedules with their payment ' \
               'history. Are you sure you want to delete this payee?',
      commit: 'Delete Payee' }
  end
end
