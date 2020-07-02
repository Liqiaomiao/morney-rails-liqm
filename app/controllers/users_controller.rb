class UsersController < ApplicationController
  def create
    user = User.new create_params
    user.save
    render_resource user

  end
  def create_params
    params.permit(:email,:password, :password_confirmation)
  end
end
