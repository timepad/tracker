class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :manage, User, :id => user.id

      can :manage, Request, :user_id => user.id
    end

    if user.admin?
      can :manage, :all

      can :sync, Request
    end
  end
end
