json.extract! user, :id, :email, :name, :bday, :created_at, :updated_at
json.url user_url(user, format: :json)
