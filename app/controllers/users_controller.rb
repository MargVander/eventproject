class UsersController < ApplicationController
  before_action :same_id, only: [:show]
  before_action :authenticate_user!, only: [:show]

  def show
    puts current_user[:id]
    puts (params[:id])
    @user = User.find(params[:id])
  end

  def same_id
    unless current_user[:id] == (params[:id]).to_i
      redirect_to root_path
    end
  end
end
