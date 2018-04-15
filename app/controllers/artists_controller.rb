class ArtistsController < ApplicationController
  def index
    # artists = Artist.all
    search_term = params[:search]
    artists = Artist.all.order(:id).where("name LIKE ?", "%#{search_term}%")
    render json: artists.as_json
  end

  def create
    artist = Artist.new(
      name: params[:name]
    )
    if artist.save
      render json: artist.as_json
    else
      render json: {errors: artist.errors.full_messages}, status: :bad_request
    end
  end
end
