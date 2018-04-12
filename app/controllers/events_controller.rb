class EventsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    events = Event.all
    # events = Event.where(artist: artist)
    # events = Event.where(venue: venue)
    render json: events.as_json
  end

  def show
    id = params[:id]
    event = Event.find_by(id: id)

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

  def destroy
    id = params[:id]
    event = Event.find_by(id: id)
    if event.destroy
      render json: {message: "event deleted"}
    else
      render json: {errors: event.errors.full_messages}
    end
  end
end
