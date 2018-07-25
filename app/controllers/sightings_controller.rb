class SightingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sighting, only: [:show, :update, :destroy]

  # GET /sightings
  # GET /sightings.json
  def index
    @sightings = @current_user.sightings.order(date: :desc)
  end

  # GET /sightings/1
  # GET /sightings/1.json
  def show
  end

  # POST /sightings
  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)
    if @sighting.save
      image = base64_to_uploaded_file(params[:sighting][:image][:file], params[:sighting][:image][:filename])
      @sighting.image.attach(image)
      render :show, status: :created, location: @sighting
    else
      render json: @sighting.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sightings/1
  # PATCH/PUT /sightings/1.json
  def update
    if @sighting.update(sighting_params)
      image = base64_to_uploaded_file(params[:sighting][:image][:file], params[:sighting][:image][:filename])
      @sighting.image.attach(image)
      render :show, status: :ok, location: @sighting
    else
      render json: @sighting.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sightings/1
  # DELETE /sightings/1.json
  def destroy
    @sighting.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sighting
    @sighting = Sighting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sighting_params
    params.require(:sighting)
      .permit(:weather, :habitat, :latitude, :longitude, :date, :species, :street_address)
      .merge({ user: @current_user})
  end

  def base64_to_uploaded_file(raw_base64, filename)
    data = extract_data(raw_base64)
    filename ||= "#{SecureRandom.urlsafe_base64}"
    return nil if data.nil?

    tempfile = Tempfile.new(filename)
    tempfile.binmode
    tempfile.write(Base64.decode64(data))
    tempfile.rewind

    ActionDispatch::Http::UploadedFile.new(
      tempfile: tempfile,
      filename: "#{filename}.jpg",
      original_filename: "#{filename}.jpg"
    )
  end

  def extract_data(data)
    return nil unless data.is_a? String

    start_regex = /data:image\/[a-z]{3,4};base64,/
    regex_result = start_regex.match(data)

    return nil unless data && regex_result

    start = regex_result.to_s
    data[start.length..-1]
  end
end
