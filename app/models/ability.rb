class Ability
  include CanCan::Ability

  def initialize(person)
    return unless person
    if person.kind_of?(Commisary)
      # registrovany clen okrskove volebni komis
      # muze opravovat a rusit svou registraci
      can [:read, :update, :destroy], Commisary, id: person.id
    elsif person.kind_of?(User)
      # Svobodny nebo Soukromnik
      # muze opravovat a rusit registraci jim registrovanych osob
      can [:read, :update, :destroy], Commisary, user_id: person.id
      if person.provider=="registr"
        # Svobodny
        # muze registrovat nove osoby ve vsech krajich
        can :create, Commisary, user_id: person.id
        can :read, Region
      else
        # Soukromnik
        # muze registrovat nove osoby pouze v koalicnich krajich
        can :create, Commisary, user_id: person.id, ward: { municipality: {region: { id: configatron.coalition_region_ids}}}
        can :read, Region, id: configatron.coalition_region_ids
      end
      # Zmocnenec
      # ma pristup k delegacnim dopisum
      unless person.represented_regions.empty?
        can [:read, :letter], Region, representative_id: person.id
      end
      # Kancelar
      # ma pristup ke vsemu
      if ["342"].member?(person.uid)
        can :manage, Commisary
        can [:read, :letter], Region
        can :read, Event
        can :read, User
      end
    end


    # Define abilities for the passed in user here. For example:
    #
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
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
