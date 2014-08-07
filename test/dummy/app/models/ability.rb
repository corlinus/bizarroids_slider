class Ability
  include CanCan::Ability

  def initialize(user)
    if user == :user
      can :manage, Bizarroids::Slider::Collection
      can :manage, Bizarroids::Slider::Slide
    end
  end
end
