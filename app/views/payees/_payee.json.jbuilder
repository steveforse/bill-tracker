# frozen_string_literal: true

json.extract! payee, :id, :name, :nickname, :website, :phone_number, :description, :created_at,
              :updated_at
json.url payee_url(payee, format: :json)
