class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]
  before_action :same_id, only: [:edit]
  before_action :not_validated_yet, only: [:show]

  def index
    @validatedevent = []
    Event.all.each do |event|
      if event.validation?
        @validatedevent << event
      end
    end
  end


  def new
    @event = Event.new
  end

  def create
    puts params
    duration = params["duration"].to_i
    price = params["price"].to_i
     @event = Event.new(start_date: params["start_date"], duration: duration, title: params["title"], description: params["description"], price: price, location: params["location"])
     @event.admin = current_user
     @event.save
     @event.picture.attach(params[:picture])
     if @event.errors.any?
       flash[:danger] = "Event creation failed"
       redirect_to request.referrer
     else
       flash[:notice] = "Event creation succeeded. Need to be validated"
       redirect_to root_path
     end


  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    puts params
    @event = Event.find(params[:id])
    eventparams = params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
    duration = eventparams["duration"].to_i
    price = eventparams["price"].to_i
     @event.update(start_date: eventparams["start_date"], duration: duration, title: eventparams["title"], description: eventparams["description"], price: price, location: eventparams["description"])
     if @event.errors.any?
       flash[:danger] = "Event edition failed"
       redirect_to request.referrer
     else
       flash[:notice] = "Event edition succeeded."
       redirect_to event_path(@event.id)
     end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

private
  def same_id
    event = Event.find(params[:id])
   unless current_user[:id] == event.admin.id
      redirect_to root_path
    end
  end

  def not_validated_yet
    event = Event.find(params[:id])
   if event.validation != true && current_user.moderator != true
      redirect_to root_path
    end
  end
end
