class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :github_client

  def github_client
    @github_client ||= client = Octokit::Client.new(
      :login => Rails.application.secrets.github_login,
      :password => Rails.application.secrets.github_password
    )
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => lambda { |exception| render_status 500 }

    rescue_from CanCan::AccessDenied, :with => lambda { |exception| render_status 403 }
    
    rescue_from ActionController::RoutingError, 
      ActionController::UnknownController, 
      ::AbstractController::ActionNotFound,
      ActiveRecord::RecordNotFound, :with => lambda { |exception| render_status 404 }
  end

  def render_404
    render_status 404
  end

  private
  def render_status status
    respond_to do |format|
      format.html { render "status_pages/#{ status }", :layout => false, :status => status }
      
      format.all { render :nothing => true, :status => status }
    end
  end
end
