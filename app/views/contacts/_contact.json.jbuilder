json.extract! contact, :id, :email, :is_valid, :created_at, :updated_at
json.url contact_url(contact, format: :json)
