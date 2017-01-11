class MessagesController < ApplicationController
  before_action :set_group , only: %i(index create)

  def index
    @groups = current_user.groups
    @message = current_user.messages.new
    @messages = @group.messages.includes(:user)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      flash[:notice] = "メッセージを投稿しました。"
    else
      flash[:alert] = "メッセージを入力してください。"
    end
    redirect_to group_messages_path(@group)
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

  def set_group
    @group =  Group.find(params[:group_id])
  end
end
