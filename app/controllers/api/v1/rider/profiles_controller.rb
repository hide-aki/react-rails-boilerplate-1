module Api
  module V1
    module Rider
      class ProfilesController < ApiController
        before_action :authenticate_request!

        def get_profile
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
          render :json => customer.to_json(:only => [:id, :phone_number, :first_name,
                                                     :last_name, :dob, :occupation,
                                                     :gender, :marital_status,
                                                     :profile_picture],
                                           :methods => [:reward_points])
        end

        def set_profile
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])

          if params[:first_name].present?
            customer.first_name = params[:first_name]
          end
          if params[:last_name].present?
            customer.last_name = params[:last_name]
          end
          if params[:dob].present?
            customer.dob = params[:dob]
          end
          if params[:occupation].present?
            customer.occupation = params[:occupation]
          end
          if params[:gender].present?
            customer.gender = params[:gender]
          end
          if params[:marital_status].present?
            customer.marital_status = params[:marital_status]
          end
          if params[:profile_picture].present?
            customer.profile_picture = params[:profile_picture]
          end
          if params[:email].present?
            customer.email = params[:email]
          end
          if params[:image].present?
            customer.image = params[:image]
          end

          if params[:image_data].present?
            customer.image_data = params[:image_data]
            customer.original_filename = params[:original_filename]
            customer.content_type = params[:content_type]
          end

          customer.save

          render :json => customer.to_json(:only => [ :id,
                                                      :phone_number,
                                                      :first_name,
                                                      :last_name,
                                                      :dob,
                                                      :occupation,
                                                      :gender,
                                                      :marital_status,
                                                      :profile_picture ])
        end

        def get_interest_categories
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])

          render :json => customer.interest_category_ids
        end

        def set_interest_categories
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
          interest_category_ids = params[:interest_category_ids]

          customer.interest_category_ids = interest_category_ids
          customer.save
          render :json => customer.interest_category_ids
        end

        def get_interest_offers
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])

          interest_categories = customer.interest_category_ids

        end

        # Get Customer app Feedback
        def get_feedback
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
          render :json => customer.to_json
        end

        # Post Customer app Feedback
        def create_feedback
          # customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
          unless params[:feedback].present?
            render json: { error: 'feebback field required' }, :status => :bad_request
            return
          end

          feedback = CustomerFeedback.new(
                                         {
                                             customer_id: @current_customer.id,
                                             feedback: params[:feedback]
                                         }
          )

          if feedback.save
            render json: feedback
          else
            render json: feedback.errors, status: :unprocessable_entity
          end
        end

        # Get Customer current location
        def get_location
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
          if customer.lat.present? && customer.lng.present?
            render :json => customer.to_json(:only => [:lat, :lng])
          else
            render :json => {:lat => 23.7568919, :lng => 90.3701279}
          end
        end

        def set_location
          unless params[:latitude].present? && params[:longitude].present?
            render json: { error: 'lat lng field missing' }, :status => :bad_request
            return
          end
          customer_location = CustomerLocation.new
          customer_location.customer_id = @auth_token['customer_id']
          customer_location.accuracy = params[:accuracy]
          customer_location.altitude = params[:altitude]
          customer_location.altitudeAccuracy = params[:altitudeAccuracy]
          customer_location.heading = params[:heading]
          customer_location.latitude = params[:latitude]
          customer_location.longitude = params[:longitude]
          customer_location.speed = params[:speed]
          customer_location.save
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
          customer.lat = params[:latitude]
          customer.lng = params[:longitude]
          if customer.save
            render json: { status: 'location saved' }
          else
            render json: { error: customer.errors }, :status => :internal_server_error
          end
        end

      #   get settings data
      def get_settings
        customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
        render :json => customer.to_json(:only => [:sound_status,
                                                   :vibrate_status,
                                                   :notification_status,
                                                   :offer_expire])
      end
      #   post settings data
        def set_settings
          customer = ApplicationRecord::Customer.find(@auth_token['customer_id'])
            customer.sound_status= params[:sound_status]
            customer.vibrate_status= params[:vibrate_status]
            customer.notification_status= params[:notification_status]
          if params[:offer_expire].present?
            customer.offer_expire= params[:offer_expire]
          end
          if customer.save
            render :json => customer.to_json(:only => [:sound_status,
                                                       :vibrate_status,
                                                       :notification_status,
                                                       :offer_expire])
          else
            render :json => customer.errors
          end

        end

      end
    end
  end
end