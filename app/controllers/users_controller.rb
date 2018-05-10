class UsersController < ApplicationController
  def show
    id = params[:id]
    user = User.find_by(id: id)

    render json: user.as_json
  end

  def create
    p "*" * 50
    p current_user
    p "*" * 50

    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if user.save
      render json: {message: "User created"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end
end
