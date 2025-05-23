module Api
  module Admin
    class EarningsController < Api::BaseController
      before_action :authenticate_admin!

      def index
        creators_earnings = Creator.includes(:digital_assets)
                                 .joins("LEFT JOIN purchase_items ON purchase_items.digital_asset_id = digital_assets.id")
                                 .select("creators.*, COALESCE(SUM(purchase_items.price_at_purchase), 0) as total_earnings")
                                 .group("creators.id")
                                 .order("creators.id")

        render json: CreatorEarningsSerializer.serialize(creators_earnings)
      end

      private

      def authenticate_admin!
        unless admin_signed_in?
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end
    end
  end
end 