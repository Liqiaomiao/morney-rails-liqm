class ApplicationController < ActionController::API
  def render_resource resource
    if resource.valid?
      render json: {resource: resource},status: 200
    else
      render json: {errors: resource.errors},status: 400
    end
  end
end
