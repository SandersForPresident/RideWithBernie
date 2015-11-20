class EventsController < ApplicationController

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    
  end

  private

    def event_params

    end
end
