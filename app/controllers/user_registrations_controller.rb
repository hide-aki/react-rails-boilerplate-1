class UserRegistrationsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :edit_password, :update_password]
  before_action :set_roles, only: [:show, :new, :create, :edit, :update, :index]

  def index
    @users = User.order('users.created_at desc').page params[:page]
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
    @user.creator_id = current_user.id

    # if @user.valid?
    #   begin
    #     User.transaction do
    #       @user.save
    #     end
    #   rescue ActiveRecord::RecordInvalid => exception
    #     raise exception
    #   end
    # end

    respond_to do |format|
      # if @user.id
      if @user.save
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
        format.html {redirect_to user_details_url(@user), notice: 'User has been updated successfully.'}
      else
        format.html {render :edit}
      end
    end
  end

  def edit_password
  end

  def update_password
    respond_to do |format|
      if @user.update(user_password_update_params)
        format.html {redirect_to user_details_url(@user), notice: 'Password has been successfully updated.'}
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

  # set roles
  def set_roles
    @roles = Role.all
  end

  # white list parameters for creating new user
  def user_params
    params.require(:user).permit(:email, :password, :status, role_ids: [])
  end

  # white list parameters for updating user
  def user_update_params
    params.require(:user).permit(:email, :status, role_ids: [])
  end

  def user_password_update_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
