class MessagesController < ApplicationController
  before_action :set_group , only: %i(index create)

  def index
    @groups = current_user.groups
    @message = Message.new
    @messages = Message.includes(:user).where(group_id:params[:group_id])
  end

  def create
    @message = Message.create(message_params)
    if @message.save
      redirect_to group_messages_path, notice: "メッセージを投稿しました。"
    else
      redirect_to group_messages_path, alert: "メッセージを入力してください。"
    end

  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id],user_id: current_user.id)
  end

  def set_group
    @group =  Group.find(params[:group_id])
  end
end
