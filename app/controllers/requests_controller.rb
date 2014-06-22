class RequestsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource :param_method => :permitted_params

  def new
    @request = Request.new
  end

  def create
    @request = Request.new permitted_params.merge(:user_id => current_user.id)

    if @request.save
      redirect_to @request
    else
      render :new
    end
  end

  def update
    if @request.update_attributes permitted_params
      redirect_to @request
    else
      render :edit
    end
  end

  def destroy
    @request.destroy

    redirect_to requests_dashboard_url
  end

  def sync
    @request = Request.find params[:request_id]

    @result = Rails.configuration.github_client.
      create_issue @request.project.github_path, @request.title, @request.content

    @request.update_attribute :github_issue_id, @result.number if @result.try(:number).present?
  end

  private
  def permitted_params
    params.require(:request).permit(:title, :content, :project_id)
  end
end
