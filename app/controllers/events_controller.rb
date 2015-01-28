class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :event_owner!, only: [:edit,:update,:destroy]

  respond_to :html

  def index
    if params[:tag]
      @events = Event.tagged_with(params[:tag])
    else
      @events = Event.all
    end
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

  def join
    @attendance = Attendance.join_event(current_user.id,  params[:event_id], 'request_sent')
    message = (@attendance.save) ? "Request Sent" : @attendance.errors.full_messages.join(", ")
    respond_with @attendance do |format|
      format.html { redirect_to event_path(@attendance.event_id), notice: message }
    end
  end

  private
    def set_event
      @event = Event.friendly.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :start_date, :end_date, :location, :agenda, :address, :organizer_id, :all_tags )
    end

    def event_owner!
      authenticate_user!
      if @event.organizer_id != current_user.id
        redirect_to events_path
        flash[:notice] = 'You do not have enough permissions to do this'
      end
    end

end
