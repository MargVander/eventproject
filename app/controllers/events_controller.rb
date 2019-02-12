class EventsController < ApplicationController

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

  def show
    @event = Event.find(params[:id])
  end
end
