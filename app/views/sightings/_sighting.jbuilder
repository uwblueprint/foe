json.extract! sighting, :id, :species, :weather, :latitude, :longitude, :habitat, :date, :created_at, :updated_at
json.url sighting_url(sighting, format: :json)
