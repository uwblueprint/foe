class Sighting < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  ALL_WEATHER = %w(sunny cloudy rain windy other)
  ALL_HABITAT = [
    "back_yard",
    "balcony/container_garden",
    "community_garden",
    "city_park",
    "rural",
    "golf_course",
    "roadside",
    "woodland",
    "farmland",
    "school_grounds",
    "other"
  ]

  validate :date_cannot_be_in_the_future

  validates :latitude, presence: true, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  validates :weather, presence: true, inclusion: { in: ALL_WEATHER }
  validates :habitat, presence: true, inclusion: { in: ALL_HABITAT }
  validates :species, inclusion: { in: BeeSpecies.all.map(&:binomial_name), allow_nil: true }

  def date_cannot_be_in_the_future
    if date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end

  def location
    @location ||= Location.new(latitude, longitude)
  end
end

class Location < Struct.new(:latitude, :longitude)
end
