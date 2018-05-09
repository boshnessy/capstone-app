class ForumsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    forums = Forum.all
    render json: forums.as_json
  end

  def create
    forum = Forum.new(
      comment: params[:comment],
      user_id: current_user.id,
      event_id: params[:event_id]
    )
    if forum.save
      render json: forum.as_json
    else
      render json: {errors: forum.errors.full_messages}, status: :bad_request
    end
  end

  def update
    id = params[:id]
    forum = Forum.find_by(id: id)

    if forum.update(
      comment: params[:comment],
      user_id: current_user.id,
      event_id: params[:event_id]
      )
      render json: forum.as_json
    else
      render json: {errors: forum.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    id = params[:id]
    forum = Forum.find_by(id: id)

    if forum.destroy
      render json: {message: "comment deleted"}
    else
      render json: {errors: forum.errors.full_messages}, status: :bad_request
    end
  end

  def forum_params
    params.require(:forum).permit(:image)
  end

  def new
    @forum = Forum.new
  end
end
# make new comment i.e. forum
# user_id = current user.id
# comment = params
# event_id = from url bar