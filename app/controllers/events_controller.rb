class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]
  before_action :same_id, only: [:edit]

  def index
    @event = Event.all
  end


  def new
    @event = Event.new
  end

  def create
    puts params
    duration = params["duration"].to_i
    price = params["price"].to_i
     @event = Event.new(start_date: params["start_date"], duration: duration, title: params["title"], description: params["description"], price: price, location: params["description"])
     @event.admin = current_user
     @event.save
     redirect_to root_path
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
     redirect_to event_path(@event.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  def same_id
    event = Event.find(params[:id])
   unless current_user[:id] == event.admin.id
      redirect_to root_path
    end
  end
end
