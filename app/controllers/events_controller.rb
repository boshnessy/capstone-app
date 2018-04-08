class EventsController < ApplicationController
  def index
    events = Event.all
    render json: events.as_json
  end

  def show
    artist = params[:artist]
    events = Event.where(artist: artist)

    # venue = params[:venue]
    # events = Event.where(venue: venue)

    # Event.where("date LIKE ?", "%Apr%")

    render json: event.as_json
  end

  def create
    event = Event.new(
      date: params[:date],
      artist: params[:artist],
      venue: params[:venue],
      city: params[:city]
    )

    if event.save
      render json: event.as_json
    else
      render json: {errors: event.errors.full_messages}
    end
  end

  def update
    id = params[:id]
    event = Event.find_by(id: id)

    if event.update(
        date: params[:date],
        artist: params[:artist],
        venue: params[:venue],
        city: params[:city]
      )
      render json: event.as_json
    else
      render json: {errors: event.errors.full_messages}
    end

  end
end
