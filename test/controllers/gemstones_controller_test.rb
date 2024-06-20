require "test_helper"

class GemstonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gemstone = gemstones(:one)
  end

  test "should get index" do
    get gemstones_url
    assert_response :success
  end

  test "should get new" do
    get new_gemstone_url
    assert_response :success
  end

  test "should create gemstone" do
    assert_difference("Gemstone.count") do
      post gemstones_url, params: { gemstone: { name: @gemstone.name } }
    end

    assert_redirected_to gemstone_url(Gemstone.last)
  end

  test "should show gemstone" do
    get gemstone_url(@gemstone)
    assert_response :success
  end

  test "should get edit" do
    get edit_gemstone_url(@gemstone)
    assert_response :success
  end

  test "should update gemstone" do
    patch gemstone_url(@gemstone), params: { gemstone: { name: @gemstone.name } }
    assert_redirected_to gemstone_url(@gemstone)
  end

  test "should destroy gemstone" do
    assert_difference("Gemstone.count", -1) do
      delete gemstone_url(@gemstone)
    end

    assert_redirected_to gemstones_url
  end
end
