class UsersController < ApplicationController
 
  # POST /users
  def create
    user = User.create(user_params)
    if user.valid? 
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    if session[:user_id]
      user = User.find(session[:user_id])
      render json: user
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  private
   

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password, :password_confirmation, :password_digest, :image_url, :bio)
    end
end