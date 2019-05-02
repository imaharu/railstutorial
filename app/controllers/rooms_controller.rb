class RoomsController < ApplicationController
  before_action :logged_in_user

  def index
    binding.pry
    @room = current_user.rooms
  end

  def create
  end
end
