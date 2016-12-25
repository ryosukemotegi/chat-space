class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def edit
    @group = Group.new(group_params)
  end

  private
  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end
end
