class Search < ActiveRecord::Base
	belongs_to :user		
	def videos
		@videos ||= find_videos
	end

	private
	def find_videos
		videos = Video.order(duration: :desc)
		videos = videos.where(fitnesstype: fitnesstype) if fitnesstype.present?
		videos = videos.where("duration <= ?", duration) if duration.present?
		videos
	end

end
