json.array!(@users) do |user|
  json.extract! user, :id, :username, :address, :city, :state, :zipcode
  json.url user_url(user, format: :json)
end
