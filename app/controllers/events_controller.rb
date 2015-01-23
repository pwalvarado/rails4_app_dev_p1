class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :event_owner!, only: [:edit,:update,:destroy]

  respond_to :html

  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    #@event = Event.new(event_params)
    @event = current_user.organized_events.new(event_params)
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :start_date, :end_date, :location, :agenda, :address, :organizer_id)
    end

    def event_owner!
      authenticate_user!
      if @event.organizer_id != current_user.id
        redirect_to events_path
        flash[:notice] = 'You do not have enough permissions to do this'
      end
    end

end
