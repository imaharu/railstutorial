class RoomsController < ApplicationController
  before_action :logged_in_user

  def index
    @rooms = current_user.rooms.paginate(page: params[:page])
    # index page have form
    @room = current_user.rooms.new
  end

  def create
    @user = current_user
    @room = @user.rooms.new(room_params)
    if @user.save
    	flash[:success] = "Room created"
    	redirect_to rooms_url
    else
      flash[:danger] = "Room not created"
    	render 'index'
    end
  end

  private

	def room_params
      params.require(:room).permit(:name)
  end
end
