class MessagesController < ApplicationController
  before_action :set_group , only: %i(index)

  def index
    @groups = current_user.groups
  end
end
