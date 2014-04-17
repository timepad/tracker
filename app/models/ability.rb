class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, User, :id => user.id

    can :manage, :all if user.admin?
  end
end
