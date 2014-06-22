class UsersController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :param_method => :permitted_params

  def update
    if @user.update_attributes permitted_params
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def permitted_params
    params.require(:user).permit(:name, :email, :skype, :vk, :twitter, :facebook, :password)
  end
end
