class ParticipationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :no_admin, only: [:create]
  before_action :same_id, only: [:index]


  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
  end

  def new
    @attendance = Attendance.new
  end

  def create
    if already_participating?
      flash[:danger] = "You are already participating"

    end
    # Amount in cents
    @event = Event.find(params[:event_id])
    @amount = @event.price * 100

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'eur'
    )

    puts params
    attendee = User.find(current_user[:id])
    event = Event.find(params[:event_id])
    a = Attendance.create(attendee: attendee, event: event, stripe_customer_id: customer.id)
    redirect_to request.referrer

  rescue Stripe::CardError => e
    flash[:error] = e.message
    #redirect_to new_charge_path
    redirect_to request.referrer
  end

  def already_participating?
   Attendance.where(attendee_id: current_user[:id], event_id: params[:event_id]).exists?
   end

   def no_admin
     event = Event.find(params[:event_id])
    unless current_user[:id] != event.admin.id
      flash[:danger] = "You can't join your own event"
      redirect_to request.referrer
    end
  end

  def same_id
    event = Event.find(params[:event_id])
   unless current_user[:id] == event.admin.id
      redirect_to root_path
    end
  end
end
