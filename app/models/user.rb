class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, :presence => true

  def admin?
    role == 'admin'
  end
end
