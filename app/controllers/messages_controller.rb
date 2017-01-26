class MessagesController < ApplicationController
  before_action :set_group , only: %i(index create)
  before_action :set_message , only: %i(index create)

  def index
    @message = current_user.messages.new
    respond_to do |format|
      format.html { render :index }
      format.json { render json:
        messageArray = []
        @messages.each do |message|
        messageArray << {
          body: message.body,
          name: message.user.name,
          image_url: message.image.url,
          created_at: message.created_at.strftime("%Y/%m/%d %H:%M:%S")
        }
      end
      render json: { messages: messageArray }
      }
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group), notice: "メッセージを投稿しました。" }
        format.json { render json: {
          body: @message.body,
          name: @message.user.name,
          image_url: @message.image.url,
          created_at: @message.created_at.strftime("%Y/%m/%d %H:%M:%S")
          }
        }
      end
    else
      flash.now[:alert] = "メッセージを入力してください。"
      render "index"
    end

  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

  def set_group
    @group =  Group.find(params[:group_id])
    @groups = current_user.groups
  end

  def set_message
    @messages = @group.messages.includes(:user)
  end

end
