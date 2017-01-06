class GroupsController < ApplicationController
  before_action :set_group , only: %i(edit update)

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: "グループが作成されました。"
    else
      redirect_to new_group_path , alert: "グループ名を入力してください。"
    end
  end

  def edit
  end

  def update
    @group.update(group_params)
    redirect_to group_messages_path(@group), notice: "チャットグループが編集されました"
  end

  private
  def set_group
    @group =  Group.find(params[:id])
  end
  
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end

end
