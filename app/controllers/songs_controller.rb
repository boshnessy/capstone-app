class SongsController < ApplicationController
  def index
    songs = Song.all
    render json: songs.as_json
  end

  def create
    song = Song.new(
      title: params[:title],
      artist_id: params[:artist_id]
    )
    if song.save
      setlist_song = SetlistSong.new(
        setlist_id: params[:setlist_id],
        song_id: song.id
      )
      setlist_song.save
      render json: song.as_json
    else
      render json: {errors: song.errors.full_messages}, status: :bad_request
    end
  end

  def update
    id = params[:id]
    song = Song.find_by(id: id)

    if song.update(
        title: params[:title],
        artist_id: params[:artist_id]
      )
      setlist_song = SetlistSong.new(
        setlist_id: params[:setlist_id],
        song_id: song.id
      )
      setlist_song.save
      render json: song.as_json
    else
      render json: {errors: song.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    id = params[:id]
    song = Song.find_by(id: id)
    if song.destroy
      render json: {message: "song deleted"}
    else
      render json: {errors: song.errors.full_messages}, status: :bad_request
    end
  end
end
