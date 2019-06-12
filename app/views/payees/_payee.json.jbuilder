json.extract! payee, :id, :name, :alternative_name, :website, :phone_number, :description, :created_at, :updated_at
json.url payee_url(payee, format: :json)
