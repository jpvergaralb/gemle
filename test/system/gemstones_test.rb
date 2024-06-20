require "application_system_test_case"

class GemstonesTest < ApplicationSystemTestCase
  setup do
    @gemstone = gemstones(:one)
  end

  test "visiting the index" do
    visit gemstones_url
    assert_selector "h1", text: "Gemstones"
  end

  test "should create gemstone" do
    visit gemstones_url
    click_on "New gemstone"

    fill_in "Name", with: @gemstone.name
    click_on "Create Gemstone"

    assert_text "Gemstone was successfully created"
    click_on "Back"
  end

  test "should update Gemstone" do
    visit gemstone_url(@gemstone)
    click_on "Edit this gemstone", match: :first

    fill_in "Name", with: @gemstone.name
    click_on "Update Gemstone"

    assert_text "Gemstone was successfully updated"
    click_on "Back"
  end

  test "should destroy Gemstone" do
    visit gemstone_url(@gemstone)
    click_on "Destroy this gemstone", match: :first

    assert_text "Gemstone was successfully destroyed"
  end
end
