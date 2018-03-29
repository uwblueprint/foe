require "application_system_test_case"

class SightingsTest < ApplicationSystemTestCase
  setup do
    @sighting = sightings(:sighting_one)
    @user = users(:user_one)
  end

  test "visiting the index" do
    # visit sightings_url
    visit sightings_url
    assert_selector "h1", text: "Sightings"
  end
end
