class Ability
  include CanCan::Ability

  def initialize(user)
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    # raise user.site_role.site_accesses.inspect

    case user.user_role
    when 'super_admin'
      can :manage, :all
      # can :manage, User do |user|
      #   user.super_admin?
      # end
      cannot [:destroy], User do |u|
        u.site_role.present?
      end
      cannot [:destroy], Tenant do |tenant|
        tenant.users.present?
      end
      cannot [:destroy], SiteRole do |role|
        role.users.present?
      end
    else
      user.site_role.site_accesses.each do |site_access|
        if site_access.write?
          can :manage, SiteAccess::RESOURCES[site_access.access_for].constantize
        elsif site_access.read?
          can :read, SiteAccess::RESOURCES[site_access.access_for].constantize
        else
          cannot :manage, SiteAccess::RESOURCES[site_access.access_for].constantize
        end
      end
    end
  end

end
