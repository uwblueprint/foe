require 'test_helper'

class SightingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sighting = sightings(:one)
    @user = users(:one)
  end

  test "should get index" do
    authenticated_get sightings_url
    assert_response :success
  end

  test "should create sighting" do
    params = {
      sighting: {
        date: @sighting.date,
        habitat: @sighting.habitat,
        weather: @sighting.weather
      }
    }

    assert_difference('Sighting.count') do
      authenticated_post sightings_url, params
    end

    assert_response 201
  end

  test "should show sighting" do
    authenticated_get sighting_url(@sighting)
    assert_response :success
  end

  test "should update sighting" do
    params = {
      sighting: {
        date: @sighting.date,
        habitat: @sighting.habitat,
        weather: @sighting.weather
      }
    }

    authenticated_put sighting_url(@sighting), params
    assert_response 200
  end

  test "should destroy sighting" do
    assert_difference('Sighting.count', -1) do
      authenticated_delete sighting_url(@sighting)
    end

    assert_response 204
  end
end
