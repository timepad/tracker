class Admin::RequestsController < AdminController
  load_and_authorize_resource :param_method => :permitted_params

  def index
    @requests = Request.order('created_at desc').page params[:page]
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new permitted_params

    if @request.save
      redirect_to [:admin, @request]
    else
      render :new
    end
  end

  def update
    if @request.update_attributes permitted_params
      redirect_to [:admin, @request]
    else
      render :edit
    end
  end

  def destroy
    @request.destroy

    redirect_to admin_requests_url
  end

  private
  def permitted_params
    params.require(:request).permit(:title, :content)
  end
end
