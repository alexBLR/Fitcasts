class VideosController < ApplicationController
  before_action :correct_trainer,   only: [:edit, :update]
  before_action :authorized_trainer, only: [:new]
  before_action :require_login, only: [:favorite]
  def new
  	@video = Video.new
  end
  def edit
    @video = Video.find(params[:id])
    
  end
def update
   @video = Video.find(params[:id])
   if @video.update_attributes(video_params)
    flash[:success] = "Video updated"
    redirect_to session.delete(:return_to)
  else
    render 'edit'
  end  
end


def show
  @home_page = true
  @user = User.new
  if signed_in?
    @latestweight = current_user.weights.where('created_at::date= ?',Date.today)
  end
  @weight = Weight.new
  session[:return_to] = request.url if request.get?
  @video = Video.find(params[:id])
  @trainer = @video.trainer.gsub(" ", "_")
  @string = @video.tubeid + "~" + @trainer
  print @string
  print @trainer
  @videos = Video.where(trainer: @video.trainer)
  if signed_in?
    @user = current_user
    @favorite=FavoriteVideo.find_by_user_id_and_video_id(@user.id,@video.id)
  end
  @home_banner  = true
end

def create
  @video = Video.new(video_params)
  if Video.find_by_tubeid(@video.tubeid).nil?
    @video.save(:validate => false)
    flash[:success] = "Video is added"
    redirect_to new_video_url
  else
    flash[:success] = "Video already exists"
    redirect_to new_video_url  
  end
end

def favorite
  @video = Video.find(params[:id])
  @user = current_user
  @favorite=FavoriteVideo.find_by_user_id_and_video_id(@user.id,@video.id)
  type = params[:type]
  if type == "favorite"
    @favorite = FavoriteVideo.new
    @favorite.video_id = @video.id
    @favorite.user_id = @user.id
    @favorite.save
    flash[:success] = "You added to favorites #{@video.name}"
    redirect_to video_path @video.id

  elsif type == "unfavorite"
    if !@favorite.blank?
      @favorite.destroy
      flash[:success] = "Unfavorited #{@video.name}"
      redirect_to video_path @video.id
    end
  else
      # Type missing, nothing happens
      flash[:success] = 'Nothing happened.'
      redirect_to video_path @video.id
    end
  end

  private
  def video_params    
    params.require(:video).permit(:fitnesstype,:level,:duration,:tubeid,:name,:equipment,:id,:difficulty,:trainer,:bodytype,:calories)
  end
 def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to signup_url # halts request cycle
    end
  end
  def correct_trainer
  @video = Video.find(params[:id])
  redirect_to session.delete(:return_to) unless current_user.trainer_name == @video.trainer
end
def authorized_trainer
    unless current_user.trainer?
      flash[:error] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
end
