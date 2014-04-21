class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, :presence => true

  has_many :requests

  def admin?
    role == 'admin'
  end
end
