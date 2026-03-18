class EntriesController < ApplicationController
  before_action :require_login

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user = @current_user
    if @entry.save
      redirect_to "/places/#{@entry.place_id}"
    else
      render :new
    end
  end

  private

  def require_login
    unless @current_user
      redirect_to "/login"
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :place_id, :image)
  end
end
