json.array!(@establishments) do |establishment|
  json.extract! establishment, :id, :name, :address, :city, :state, :zipcode, :email, :key
  json.url establishment_url(establishment, format: :json)
end
