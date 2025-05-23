require "application_system_test_case"

class PurchaseItemsTest < ApplicationSystemTestCase
  setup do
    @purchase_item = purchase_items(:one)
  end

  test "visiting the index" do
    visit purchase_items_url
    assert_selector "h1", text: "Purchase items"
  end

  test "should create purchase item" do
    visit purchase_items_url
    click_on "New purchase item"

    fill_in "Digital asset", with: @purchase_item.digital_asset_id
    fill_in "Price at purchase", with: @purchase_item.price_at_purchase
    fill_in "Purchase", with: @purchase_item.purchase_id
    click_on "Create Purchase item"

    assert_text "Purchase item was successfully created"
    click_on "Back"
  end

  test "should update Purchase item" do
    visit purchase_item_url(@purchase_item)
    click_on "Edit this purchase item", match: :first

    fill_in "Digital asset", with: @purchase_item.digital_asset_id
    fill_in "Price at purchase", with: @purchase_item.price_at_purchase
    fill_in "Purchase", with: @purchase_item.purchase_id
    click_on "Update Purchase item"

    assert_text "Purchase item was successfully updated"
    click_on "Back"
  end

  test "should destroy Purchase item" do
    visit purchase_item_url(@purchase_item)
    click_on "Destroy this purchase item", match: :first

    assert_text "Purchase item was successfully destroyed"
  end
end
