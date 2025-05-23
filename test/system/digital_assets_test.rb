require "application_system_test_case"

class DigitalAssetsTest < ApplicationSystemTestCase
  setup do
    @digital_asset = digital_assets(:one)
  end

  test "visiting the index" do
    visit digital_assets_url
    assert_selector "h1", text: "Digital assets"
  end

  test "should create digital asset" do
    visit digital_assets_url
    click_on "New digital asset"

    fill_in "Creator", with: @digital_asset.creator_id
    fill_in "Description", with: @digital_asset.description
    fill_in "File url", with: @digital_asset.file_url
    fill_in "Price", with: @digital_asset.price
    fill_in "Title", with: @digital_asset.title
    click_on "Create Digital asset"

    assert_text "Digital asset was successfully created"
    click_on "Back"
  end

  test "should update Digital asset" do
    visit digital_asset_url(@digital_asset)
    click_on "Edit this digital asset", match: :first

    fill_in "Creator", with: @digital_asset.creator_id
    fill_in "Description", with: @digital_asset.description
    fill_in "File url", with: @digital_asset.file_url
    fill_in "Price", with: @digital_asset.price
    fill_in "Title", with: @digital_asset.title
    click_on "Update Digital asset"

    assert_text "Digital asset was successfully updated"
    click_on "Back"
  end

  test "should destroy Digital asset" do
    visit digital_asset_url(@digital_asset)
    click_on "Destroy this digital asset", match: :first

    assert_text "Digital asset was successfully destroyed"
  end
end
