class Admin::UsersController < AdminController
  load_and_authorize_resource :param_method => :permitted_params

  def new
    @user = User.new
  end

  def create
    @user = User.new permitted_params

    if @user.save
      redirect_to [:admin, @user]
    else
      render :new
    end
  end

  def index
    @users = User.page params[:page]
  end

  def update
    if @user.update_attributes permitted_params
      redirect_to [:admin, @user]
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_url
  end

  private
  def permitted_params
    params.require(:user).permit(:name, :email, :skype, :vk, :twitter, :facebook, :password)
  end
end
