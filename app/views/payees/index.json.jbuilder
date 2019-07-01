# frozen_string_literal: true

json.array! @payees, partial: 'payees/payee', as: :payee
