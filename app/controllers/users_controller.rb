class UsersController < ApplicationController
  def search
    @users = User.where('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.json { render json: @users}
end
