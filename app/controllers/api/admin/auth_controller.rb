module Api
  module Admin
    class AuthController < ApplicationController
      skip_before_action :verify_authenticity_token

      def login
        admin = AdminUser.authenticate(params[:email], params[:password])
        if admin
          session[:admin_id] = admin.id
          render json: { 
            status: 'success',
            message: 'Logged in successfully',
            admin: {
              id: admin.id,
              email: admin.email,
              name: admin.name
            }
          }
        else
          render json: { 
            status: 'error',
            message: 'Invalid email or password'
          }, status: :unauthorized
        end
      end

      def logout
        session[:admin_id] = nil
        render json: { 
          status: 'success',
          message: 'Logged out successfully'
        }
      end
    end
  end
end 