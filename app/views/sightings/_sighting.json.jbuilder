json.extract! sighting, :id, :weather, :habitat, :image_url, :date, :created_at, :updated_at
json.url sighting_url(sighting, format: :json)
