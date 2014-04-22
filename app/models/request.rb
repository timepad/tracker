class Request < ActiveRecord::Base
  validates :title, :presence => true, :uniqueness => true

  validates :user_id, :presence => true

  validates :project_id, :presence => true

  belongs_to :user

  belongs_to :project

  def synced?
    github_issue_id.present?
  end
end
