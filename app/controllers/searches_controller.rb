class SearchesController < ApplicationController
before_action :authorized_trainer, only: [:myvideos]
	include SessionsHelper	
	def new
		
		session[:return_to] = request.url if request.get?
		@search = Search.new
		@home_page = true
		@search = Search.new
		videos = Video.order(duration: :desc)
		videos = videos.where(:fitnesstype => 'fat burning')
		videos = videos.where("duration <= ?", 10) 
		@videos = videos.limit(6)
		@programs=Program.limit(6)
	end
def hangout
end

def myvideos
@search = Search.new
			videos = Video.order(duration: :desc)
			videos = videos.where(:trainer => current_user.trainer_name)
			@videos = videos

end

def realfittv
	@search = Search.new
	#@videos = Video.where(trainer: "RealFitTV")
	@videos = Video.where(trainer: "RealFitTV")
	@categories = @videos.uniq_by(&:fitnesstype)
end

def realfittvsearch
	@search = Search.new
			videos = Video.order(duration: :desc)
			videos = videos.where(:trainer => 'RealFitTV')
			videos = videos.where(:fitnesstype => params[:type]) 
			@videos = videos
end

	def advanced
		@home_page = true
		session[:return_to] = request.url if request.get?
		if signed_in?
			@searches = current_user.searches.last
			

			if @searches.blank?
				videos = Video.order(duration: :desc)
				videos = videos.where(:fitnesstype => 'fat burning')
				videos = videos.where("duration <= ?", 10) 
				@videos = videos.limit(9)
			else
				videos = Video.order(duration: :desc)
				videos = videos.where(:fitnesstype => @searches.fitnesstype) 
				videos = videos.where("duration <= ?", @searches.duration)
				@videos = videos

			end
			@search = Search.new
			
		else
			@search = Search.new
			videos = Video.order(duration: :desc)
			videos = videos.where(:fitnesstype => 'fat burning')
			videos = videos.where("duration <= ?", 10) 
			@videos = videos.limit(9)

		end
	end
	def create

		if params[:start_button]
			@search = Search.create!(search_params)
			videos = Video.order(duration: :desc)
			videos = videos.where(:fitnesstype => @search.fitnesstype)
			videos = videos.where("duration <= ?", @search.duration) 
			offset = rand(videos.count)
			videos = videos.first(:offset => offset)
			redirect_to video_path videos.id
		else
			@search = Search.new(search_params)
			if current_user
				@search.user_id = current_user.id
			end
			@search.save(:validate => false)
			if current_user
				redirect_to @search
			else
				redirect_to @search
			end
		end

	end

	def update

		if params[:start_button]
			@search = Search.create!(search_params)
			videos = Video.order(duration: :desc)
			videos = videos.where(:fitnesstype => @search.fitnesstype)
			videos = videos.where("duration <= ?", @search.duration) 
			offset = rand(videos.count)
			videos = videos.first(:offset => offset)
			redirect_to video_path videos.id
		else
			@search = Search.new(search_params)
			if current_user
				@search.user_id = current_user.id
			end
			@search.save(:validate => false)
			if current_user
				redirect_to @search
			else
				redirect_to @search
			end
		end

	end


	def show
		@home_page = true
		session[:return_to] = request.url if request.get?
		@search = Search.find(params[:id])
	end


	private
	def authorized_trainer
    unless current_user.trainer?
      flash[:error] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
	def search_params    
		params.require(:search).permit(:fitnesstype,:level,:duration,:user_id, :calories)
	end
end
