class EventsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    events = Event.all
    # sort_by_venue = params[:venue]
    # sort_by_city = params[:city]
    # sort_by_state = params[:state]

    # p sort_by_venue
    # if sort_by_venue
    #   events = Event.all.where("venue LIKE ?", "%#{sort_by_venue}%")
    # elsif sort_by_city
    #   events = Event.all.where("city LIKE ?", "%#{sort_by_city}%")
    # elsif sort_by_state
    #   events = Event.all.where("state LIKE ?", "%#{sort_by_state}%")
    # end
    
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
      venue: params[:venue],
      city: params[:city],
      state: params[:state]
    )
    if artist = Artist.find_by(name: params[:artist])
      if event.save
        artist_event = ArtistEvent.new(
          event_id: event.id,
          artist_id: artist.id
        )
        artist_event.save
        render json: event.as_json
      else
        render json: {errors: event.errors.full_messages}, status: :bad_request
      end
    else
      # artist = Artist.new(name: params[:name])
      if event.save
        artist = Artist.new(
          name: params[:artist]
        )
        artist.save
        render json: event.as_json
      else
        render json: {errors: event.errors.full_messages}, status: :bad_request
      end
    end
  end

  def update
    id = params[:id]
    event = Event.find_by(id: id)

    if event.update(
        date: params[:date],
        venue: params[:venue],
        city: params[:city],
        state: params[:state]
      )
      render json: event.as_json
    else
      render json: {errors: event.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    id = params[:id]
    event = Event.find_by(id: id)
    if event.destroy
      render json: {message: "event deleted"}
    else
      render json: {errors: event.errors.full_messages}, status: :bad_request
    end
  end
end
