module Api
  module V1
    module Rider
      class AuthController < ApiController
        before_action :authenticate_request!, only: [:logout]

        def authenticate
          unless params[:email].present?
            render json: { errors: {phone: 'field required'} }, status: :bad_request
            return
          end
          unless params[:password].present?
            render json: { errors: {password: 'field required'} }, status: :bad_request
            return
          end
          unless params[:role].present?
            render json: { errors: {role: 'field required'} }, status: :bad_request
            return
          end

          user = ApplicationRecord::User.find_for_database_authentication(email: params[:email])

          if user.present? && user.valid_password?(params[:password]) && user.has_role?(params[:role].to_sym)
            render json: payload(user)
          else
            render json: { errors: ['Invalid Email/Password'] }, status: :unauthorized
          end
        end

        def set_facebook_id
          unless params[:facebook_id].present?
            render json: { error: 'facebook_id field required' }, :status => :bad_request
            return
          end
          ApplicationRecord::Customer.where(facebook_id: params[:facebook_id])
              .update_all(facebook_id: nil)

          @current_user.facebook_id = params[:facebook_id]
          if @current_user.save
            render :json => true
          else
            render json: @current_user.errors, status: :unprocessable_entity

          end
        end

        def delete_facebook_id
          @current_user.facebook_id = nil
          if @current_user.save
            render :json => true
          else
            render json: @current_user.errors, status: :unprocessable_entity
          end
        end
        def authenticate_user
          user = User.find_for_database_authentication(email: params[:email])
          if user.valid_password?(params[:password])
            render json: payload(user)
          else
            render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
          end
        end

        def refresh_token
          render :json => "refresh_token"
        end

        def logout
          render :json => "logout"
        end

        private def payload(user)
          exp = Time.now.to_i + 20
          return     {
              auth_token: JsonWebToken.encode(data: {
                  user_id: user.id,
                  role: params[:role]
              },
                  # exp: exp
              ),
              data: user
          }
        end
      end
    end
  end
end