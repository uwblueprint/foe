json.extract! sighting, :id, :species, :weather, :latitude, :longitude, :habitat, :date, :created_at, :updated_at

json.image_url rails_blob_url(sighting.image) if sighting.image.attached?
json.url sighting_url(sighting, format: :json)
