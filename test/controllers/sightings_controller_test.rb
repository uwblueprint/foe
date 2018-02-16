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
    file = fixture_file_upload('files/bee_logo.png', 'image/png')
    params = {
      sighting: {
        date: @sighting.date,
        habitat: @sighting.habitat,
        weather: @sighting.weather,
        image: file
      }
    }

    assert_difference('Sighting.count') do
      authenticated_post sightings_url, params
    end

    assert_response 201
  end

  test "should return 422 for invalid sighting" do
    params = {
      sighting: {
        date: @sighting.date,
      }
    }

    authenticated_post sightings_url, params
    assert_response 422
  end

  test "should show sighting" do
    authenticated_get sighting_url(@sighting)
    assert_response :success
  end

  test "should update sighting" do
    file = fixture_file_upload('files/bee_logo.png', 'image/png')
    params = {
      sighting: {
        date: @sighting.date,
        habitat: @sighting.habitat,
        weather: @sighting.weather,
        image: file
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
