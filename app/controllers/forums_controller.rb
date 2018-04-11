class ForumsController < ApplicationController
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
      render json: {errors: forum.errors.full_messages}
    end
  end
end
