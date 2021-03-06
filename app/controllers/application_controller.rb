class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => lambda { |_exception| render_status 500 }

    rescue_from CanCan::AccessDenied, :with => lambda { |_exception| render_status 403 }

    rescue_from ActionController::RoutingError,
                ActionController::UnknownController,
                ::AbstractController::ActionNotFound,
                ActiveRecord::RecordNotFound, :with => lambda { |_exception| render_status 404 }
  end

  def render_404
    render_status 404
  end

  private

  def render_status(status)
    respond_to do |format|
      format.html { render "status_pages/#{ status }", :layout => false, :status => status }

      format.all { render :nothing => true, :status => status }
    end
  end
end
