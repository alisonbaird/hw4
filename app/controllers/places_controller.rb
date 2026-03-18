class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = @place.entries.where(user: @current_user) if @current_user
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

  private

  def require_login
    unless @current_user
      redirect_to "/login"
    end
  end
end
