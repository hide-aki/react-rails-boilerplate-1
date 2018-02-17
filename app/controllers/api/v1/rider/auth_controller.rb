module Api
  module V1
    module Rider
      class AuthController < ApiController
        before_action :authenticate_request!, only: [:set_facebook_id, :delete_facebook_id]

        def verify_token
          user_access_token = params[:token]
          account_kit_app_secret = Rails.application.secrets.FB_ACCOUNT_KIT_APP_SECRET
          appsecret_proof = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), account_kit_app_secret, user_access_token)
          ret_url = get_me_url(user_access_token, appsecret_proof)
          url = URI.parse(ret_url)
          response = Net::HTTP.get_response url
          parsed_response = JSON.parse(response.body)

          res_data = create_or_update_customer(parsed_response, params[:deviceId], params[:playerId], params[:pushToken])

          render :json => payload(res_data)
        end

        def authenticate
          unless params[:phone].present? && params[:password]
            render json: { errors: ['`phone` `password` field required'] }, status: :bad_request
            return
          end
          user = ApplicationRecord::StoreManager.find_by_phone(params[:phone])

          if user.present? && user.authenticate(params[:password])
            render json: payload(user)
          else
            render json: { errors: ['Invalid Phone/Password'] }, status: :unauthorized
          end
        end
        def set_facebook_id
          unless params[:facebook_id].present?
            render json: { error: 'facebook_id field required' }, :status => :bad_request
            return
          end
          ApplicationRecord::Customer.where(facebook_id: params[:facebook_id])
              .update_all(facebook_id: nil)

          @current_customer.facebook_id = params[:facebook_id]
          if @current_customer.save
            render :json => true
          else
            render json: @current_customer.errors, status: :unprocessable_entity

          end
        end

        def delete_facebook_id
          @current_customer.facebook_id = nil
          if @current_customer.save
            render :json => true
          else
            render json: @current_customer.errors, status: :unprocessable_entity
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
        private def get_me_url(access_token, appsecret_proof)
          return "https://graph.accountkit.com/v1.0/me/?access_token=#{access_token}&appsecret_proof=#{appsecret_proof}"
        end

        def create_or_update_customer(parsed_response, device_id, player_id, push_token)
          ak_id = parsed_response['id'];
          phone_number = parsed_response['phone']['number'];
          phone_country_prefix = parsed_response['phone']['country_prefix'];
          phone_national_number = parsed_response['phone']['national_number'];

          customer = ApplicationRecord::Customer.find_by_ak_id_and_phone_number(ak_id, phone_number)

          if customer.present?
            customer.sign_in_count = customer.sign_in_count + 1
          else
            customer = ApplicationRecord::Customer.new
            customer.ak_id = ak_id
            customer.phone_number = phone_number
            customer.phone_country_prefix = phone_country_prefix
            customer.phone_national_number = phone_national_number
          end

          if device_id.present?
            customer.last_sign_in_mobile_id = customer.current_sign_in_mobile_id
            customer.current_sign_in_mobile_id = device_id
          end

          if player_id.present?
            customer.player_id = player_id
          end

          if push_token.present?
            customer.push_token = push_token
          end

          if customer.save
            return customer
          else
            return customer
          end
        end
        private def payload(customer)
          return     {
              auth_token: JsonWebToken.encode({customer_id: customer.id}),
              data: customer
          }
        end
        # def payload_old(user)
        #   return nil unless user and user.id
        #   {
        #       auth_token: JsonWebToken.encode({user_id: user.id}),
        #       user: {id: user.id, email: user.email}
        #   }
        # end
      end
    end
  end
end