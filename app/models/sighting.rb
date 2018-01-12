class Sighting < ApplicationRecord
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

  validates :weather, presence: true, inclusion: { in: ALL_WEATHER }
  validates :habitat, presence: true, inclusion: { in: ALL_HABITAT }

end
