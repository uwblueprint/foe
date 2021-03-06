require 'test_helper'

class SightingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sighting = sightings(:sighting_one)
    image = fixture_file_upload('files/bee_logo.png', 'image/png')
    @sighting.image.attach(image)

    @user = users(:user_one)
    sign_in @user
  end

  test "should get index" do
    authenticated_get sightings_url
    assert_response :success

    response_json.each { |s| assert Sighting.find(s['id']).user == @user }
  end

  test "should show sighting" do
    authenticated_get sighting_url(@sighting)
    assert_response :success
  end

  test "should build correct json" do
    authenticated_get sighting_url(@sighting)

    assert_equal response_json['id'], @sighting.id
    assert_equal response_json['weather'], @sighting.weather
    assert_equal response_json['latitude'], @sighting.latitude
    assert_equal response_json['longitude'], @sighting.longitude
    assert_equal response_json['habitat'], @sighting.habitat
    assert_equal response_json['date'], @sighting.date.to_s

    assert_not_empty response_json['image_url']
  end

  test "should create sighting" do
    file = fixture_file_upload('files/bee_logo.png', 'image/png')
    base64_file = Base64.encode64(file.tempfile.open.read.force_encoding(Encoding::UTF_8))

    params = {
      sighting: {
        habitat: @sighting.habitat,
        weather: @sighting.weather,
        date: @sighting.date,
        latitude: @sighting.latitude,
        longitude: @sighting.longitude,
        image: {
          file: "data:image/png;base64,#{base64_file}"
        },
      }
    }

    assert_difference('ActiveStorage::Attachment.count', 1) do
      assert_difference('Sighting.count') do
        authenticated_post sightings_url, params
        assert_response 201
      end
    end
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

  test "should update sighting" do
    file = fixture_file_upload('files/bee_logo.png', 'image/png')
    base64_file = Base64.encode64(file.tempfile.open.read.force_encoding(Encoding::UTF_8))

    params = {
      sighting: {
        habitat: @sighting.habitat,
        weather: @sighting.weather,
        latitude: @sighting.latitude,
        longitude: @sighting.longitude,
        image: file_hash = {
          file: "data:image/png;base64,#{base64_file}",
        },
      }
    }

    authenticated_put sighting_url(@sighting), params
    assert_response 200
  end

  test "should destroy sighting" do
    assert_difference('Sighting.count', -1) do
      authenticated_delete sighting_url(@sighting)
      assert_response 204
    end
  end
end
