class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new
    if user.admin
      can :manage, :all
    elsif user.role == 'server'
      can :manage, Device, :server_id => user._id
      can :manage, Job, :server_id => user._id
      can :manage, JobReport, JobReport do | jobreport |
        jobreport.job.server_id == user._id
      end
      can :manage, Measurement, Measurement do | measurement |
        measurement.device.server_id == user._id
      end
      can :manage, Server, :_id => user._id
    else
      can :update, User, :_id => user.id
      can :read, :all
    end

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
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
