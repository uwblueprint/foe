require 'test_helper'

class SightingTest < ActiveSupport::TestCase
  test "invalid sighting" do
    @sighting = Sighting.create(
      weather: "invalid_weather",
      habitat: "invalid_habitat",
      date: "2017-07-03"
    )
    assert_not @sighting.valid?
  end
end
