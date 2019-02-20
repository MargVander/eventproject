class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_modo
  def index
    @user = User.all
  end

  def destroy
    @user = User.find(params[:id])

        if Event.exists?(admin: @user)
          Event.find_by(admin: @user).destroy
        end

        if Attendance.exists?(attendee: @user)
          Attendance.where(attendee: @user).each do |atd|
            atd.destroy
          end
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
