class Admin::SightingsController < ApplicationController
  before_action :set_sighting, only: [:show]

  # GET /sightings
  # GET /sightings.json
  def index
    @sightings = Sighting.all
  end

  # GET /sightings/1
  # GET /sightings/1.json
  def show
  end

  private

  def set_sighting
    @sighting = Sighting.find(params[:id])
  end
end
