require "test_helper"

class DigitalAssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @digital_asset = digital_assets(:one)
  end

  test "should get index" do
    get digital_assets_url
    assert_response :success
  end

  test "should get new" do
    get new_digital_asset_url
    assert_response :success
  end

  test "should create digital_asset" do
    assert_difference("DigitalAsset.count") do
      post digital_assets_url, params: { digital_asset: { creator_id: @digital_asset.creator_id, description: @digital_asset.description, file_url: @digital_asset.file_url, price: @digital_asset.price, title: @digital_asset.title } }
    end

    assert_redirected_to digital_asset_url(DigitalAsset.last)
  end

  test "should show digital_asset" do
    get digital_asset_url(@digital_asset)
    assert_response :success
  end

  test "should get edit" do
    get edit_digital_asset_url(@digital_asset)
    assert_response :success
  end

  test "should update digital_asset" do
    patch digital_asset_url(@digital_asset), params: { digital_asset: { creator_id: @digital_asset.creator_id, description: @digital_asset.description, file_url: @digital_asset.file_url, price: @digital_asset.price, title: @digital_asset.title } }
    assert_redirected_to digital_asset_url(@digital_asset)
  end

  test "should destroy digital_asset" do
    assert_difference("DigitalAsset.count", -1) do
      delete digital_asset_url(@digital_asset)
    end

    assert_redirected_to digital_assets_url
  end
end
