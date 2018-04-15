class SetlistsController < ApplicationController
  def index
    setlists = Setlist.all
    render json: setlists.as_json
  end

  def create
    setlist = Setlist.new(
      event_id: params[:event_id]
    )
    if setlist.save
      render json: setlist.as_json
    else
      render json: {errors: setlist.errors.full_messages}, status: :bad_request
    end
  end

  def update
    id = params[:id]
    setlist = Setlist.find_by(id: id)

    if setlist.update(
        event_id: params[:event_id]
      )
      render json: setlist.as_json
    else
      render json: {errors: setlist.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    id = params[:id]
    setlist = Setlist.find_by(id: id)
    if setlist.destroy
      render json: {message: "setlist deleted"}
    else
      render json: {errors: setlist.errors.full_messages}, status: :bad_request
    end
  end
end