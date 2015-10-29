json.array!(@deals) do |deal|
  json.extract! deal, :id, :keyword, :description, :current, :permanent
  json.url deal_url(deal, format: :json)
end
