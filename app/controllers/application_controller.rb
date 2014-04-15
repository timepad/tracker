class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :github_client

  def github_client
    @github_client ||= client = Octokit::Client.new(
      :login => Rails.application.secrets.github_login,
      :password => Rails.application.secrets.github_password
    )
  end
end
