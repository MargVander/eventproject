class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_modo
  def index
    @user = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.events.each do |event|
      event.destroy
    end
    @user.attendances.each do |attendance|
      attendance.destroy
    end
    @user.destroy
    redirect_to request.referrer
  end

  private
  def check_if_modo
    unless current_user.moderator?
     redirect_to root_path
   end
 end
end
