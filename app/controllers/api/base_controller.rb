module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_admin!

    private

    def authenticate_admin!
      unless admin_signed_in?
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
  end
end 