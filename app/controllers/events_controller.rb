class EventsController < ApplicationController
  def index
    events = Event.all
    render json: events.as_json
  end
end
