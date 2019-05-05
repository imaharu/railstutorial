class RoomsController < ApplicationController
  before_action :logged_in_user

  def index
    @rooms = current_user.rooms.paginate(page: params[:page])
    # index page have form
    @room = current_user.rooms.new
  end

  def show
    room = Room.find(params[:id])
    @users = room.users
    @messages = room.messages
    @message = room.messages.new
  end

  def create
    user = current_user
    room = user.rooms.new(room_params)
    if user.save
    	flash[:success] = "Room created"
    	redirect_to rooms_url
    else
      flash[:danger] = "Room not created"
    	render 'index'
    end
  end

  def destroy
    Room.find(params[:id]).destroy
    flash[:success] = "Room deleted"
    redirect_to rooms_url
  end

  def message_create
    room = Room.find(params[:id])
    message = room.messages.new(message_params)
    if message.save
      flash[:success] = "Message created"
      redirect_to room_url
    else
      flash[:danger] = "Message not created"
    	render 'show'
    end
  end

  private

	def room_params
    params.require(:room).permit(:name)
  end
  
  def message_params
    params.require(:message).permit(:message).merge(send_user_id: current_user.id)
  end
end
