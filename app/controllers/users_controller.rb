class UsersController < ApplicationController
  def create
    user = User.new create_params
    user.save
    render_resource user

  end
  def create_params
    params.permit(:email,:password, :password_confirmation)
  end
  def render_resource resource
    if resource.valid?
      render json: {resource: resource},status: 200
    else
      render json: {errors: resource.errors},status: 400
    end
  end
end
