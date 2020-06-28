class UsersController < ApplicationController
  def create
    u = User.new
    u.email = params[:email]
    u.password = params[:password]
    u.save
  end
end
