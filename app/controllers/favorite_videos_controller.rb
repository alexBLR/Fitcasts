class FavoriteVideosController < ApplicationController
  before_action :require_login, only: [:show]
  def show
  	@home_page = true
    @videos=current_user.videos.all
  end
  private
  def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to signin_url # halts request cycle
    end
  end
end
