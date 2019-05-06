class RoomsController < ApplicationController
  before_action :logged_in_user

  def index
    @rooms = current_user.rooms.paginate(page: params[:page])
    # index page have form
    @room = current_user.rooms.new
  end

  def show
    room = Room.find(params[:id])
    @room_users = room.users
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

  def add_users
    room = Room.find(params[:id])
    user = User.find_by(atmark: params[:atmark])
    entry = Entry.new(user_id: user&.id, room_id: room&.id)
    if entry.save
      flash[:success] = "Add User"
    else
      flash[:danger] = "Not Add User"
    end
    redirect_to room_url
  end

  def message_create
    room = Room.find(params[:id])
    message = room.messages.new(message_params)
    if message.save
      flash[:success] = "Message created"
    else
      flash[:danger] = "Message not created"
    end
    redirect_to room_url
  end

  private

	def room_params
    params.require(:room).permit(:name)
  end
  
  def message_params
    params.require(:message).permit(:message).merge(send_user_id: current_user.id)
  end
end
