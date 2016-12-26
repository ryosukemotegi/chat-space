class GroupsController < ApplicationController
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

  private
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end
end
