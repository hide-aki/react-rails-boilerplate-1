class UserRegistrationsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :edit_password, :update_password]

  def index
    @users = User.order('users.created_at desc')
  end

  def show
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @user.creator_id = current_user.id

    if @user.valid?
      begin
        User.transaction do
          @user.save
        end
      rescue ActiveRecord::RecordInvalid => exception
        raise exception
      end
    end

    respond_to do |format|
      if @user.id
        format.html {redirect_to user_details_url(@user), notice: 'User has been created successfully'}
      else
        # @user.user_profile = @user.build_user_profile(user_profile_params)
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_update_params)
        format.html {redirect_to user_details_url(@user), notice: 'User has been updated successfully'}
      else
        format.html {render :edit}
      end
    end
  end

  def edit_password
    # @user = User.find(params[:user_registration_id])
  end

  def update_password
    # @user = User.find(params[:user_registration_id])
    respond_to do |format|
      if (@user.update(user_password_update_params))
        format.html {redirect_to user_details_url(@user), notice: 'Password has benn updated successfully'}
      else
        format.html {render :edit_password}
      end
    end
  end

  private

  # set user form param id
  def set_user
    @user = User.find(params[:id])
  end

  # white list parameters for creating new user
  def user_params
    params.require(:user).permit(:email, :password)
  end

  # white list parameters for updating user
  def user_update_params
    params.require(:user).permit(:email)
  end

  def user_password_update_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
