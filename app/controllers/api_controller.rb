class ApiController < ActionController::API

  attr_reader :current_user

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: {errors: ['Not Authenticated']}, status: :unauthorized
      return
    end
    @current_user = ApplicationRecord::User.find_by_id(auth_token[:data][:user_id])
    if !@current_user.present?
      render json: {errors: ['User not found']}, status: :unauthorized
      return
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {errors: ['Not Authenticated']}, status: :unauthorized
  end

  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    puts auth_token
    http_token && auth_token && auth_token[:data][:user_id].to_i
  end
end
