class MessagesController < ApplicationController
  before_action :set_group , only: %i(index create)

  def index
    @groups = current_user.groups
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id],user_id: current_user.id)
  end

  def set_group
    @group =  Group.find(params[:group_id])
  end
end
