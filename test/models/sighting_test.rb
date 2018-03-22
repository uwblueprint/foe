require 'test_helper'

class SightingTest < ActiveSupport::TestCase
  test "valid sighting" do
    @sighting = sightings(:sighting_one)
    assert @sighting.valid?
  end

  test "invalid sighting" do
    @sighting = Sighting.create(
      weather: "sunny",
      habitat: "other",
      latitude: 1203,
      longitude: -80.5423533,
      date: "2017-07-03",
    )
    assert_not @sighting.valid?
  end

  test "invalid species" do
    @sighting = sightings(:sighting_one)
    @sighting.species = 'bombus_invalid'
    assert_not @sighting.valid?
    assert_includes @sighting.errors.messages[:species], "is not included in the list"
  end

  test "postdated sighting" do
    @sighting = sightings(:sighting_one)
    @sighting.date = Date.today + 1
    assert_not @sighting.valid?
    assert_includes @sighting.errors.messages[:date], "can't be in the future"
  end
end
