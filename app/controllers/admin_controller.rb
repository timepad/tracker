class AdminController < ApplicationController
  before_filter :verify_admin

  private
  def verify_admin
    unless current_user && current_user.admin?
      raise CanCan::AccessDenied
    end
  end
end
