class UsersController < ApplicationController
  def create
    user = User.new create_params
    if user.save
      render json: {resource: user},status: 200
    else
      render json: {errors: user.errors},status: 400
    end

  end
  def create_params
    params.permit(:email,:password, :password_confirmation)
  end
end
