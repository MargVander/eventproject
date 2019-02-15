class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_modo
  def index
    @unvalidatedevent = []
    Event.all.each do |event|
      unless event.validation?
        @unvalidatedevent << event
      end
    end
  end

  def create
    @event = Event.find(params["format"])
    @event.validation = true
    @event.save
    redirect_to request.referrer
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to request.referrer
  end

  private
  def check_if_modo
    unless current_user.moderator?
     redirect_to root_path
   end
 end
end
