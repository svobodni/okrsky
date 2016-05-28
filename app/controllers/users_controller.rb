class UsersController < ApplicationController
  def index
    @users = User.accessible_by(current_ability).includes(:commisaries)
  end
end
