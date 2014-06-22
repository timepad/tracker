class AdminController < ApplicationController
  before_action :verify_admin

  private
  def verify_admin
    unless current_user && current_user.admin?
      fail CanCan::AccessDenied
    end
  end
end
