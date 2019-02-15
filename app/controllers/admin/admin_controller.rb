class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_modo

  def index

  end

  private
  def check_if_modo
    unless current_user.moderator?
     redirect_to root_path
   end
 end
end
