class UsersController < ApplicationController
  def create
    a = params.permit(:email,:password, :password_confirmation)
    user = User.new(a)
    if user.save
      render json: {resource: user},status: 200
    else
      render json: {errors: user.errors},status: 400
    end

  end
end
