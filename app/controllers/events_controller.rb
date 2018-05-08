class EventsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    p "*****" * 50
    p current_user
    p "*****" * 50
    events = Event.all
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
        image = Image.new(
          artist_id: artist.id,
          event_id: event.id,
          url: params[:image]
        )
        image.save
        setlist = Setlist.new(
          event_id: event.id,
          artist_id: artist.id
        )
        setlist.save
        render json: event.as_json
      else
        render json: {errors: event.errors.full_messages}, status: :bad_request
      end
    else
      if event.save
        artist = Artist.new(
          name: params[:artist]
        )
        artist.save
        artist_event = ArtistEvent.new(
          event_id: event.id,
          artist_id: artist.id
        )
        artist_event.save
        image = Image.new(
          artist_id: artist.id,
          event_id: event.id,
          url: params[:image]
        )
        image.save
        setlist = Setlist.new(
          event_id: event.id,
          artist_id: artist.id
        )
        setlist.save
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
