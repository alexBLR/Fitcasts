class ProgramsController < ApplicationController
  before_action :authorize_admin, only: [:edit]
  before_action :require_login, only: [:makemine, :create]
  
  def makemine
  	program = Program.find(params[:id])
  	start_time = Time.zone.now.to_datetime
    start_time = start_time.in_time_zone(current_user.timezone)
    offset = (start_time.utc_offset)/60/60
    adjusted_start_time = (start_time-offset.hours).utc
    if current_user.workouts.blank?
      @workouts = program.workouts.order('day').uniq_by(&:video_id)
      for i in 0..(@workouts.length-1)
       @workout = Workout.new
       @workout.user_id = current_user.id
       @workout.program_id = program.id
       @workout.day = @workouts[i].day
       @workout.video_id = @workouts[i].video_id
       @workout.created_at = adjusted_start_time
       @workout.save(:validate => false)	
     end
     flash[:error] = "You are enrolled in a great fitness program!"
     redirect_to programs_path
   elsif current_user.workouts[0].program_id != program.id
    Workout.where(:user_id => current_user.id).delete_all
    @workouts = program.workouts.order('day').uniq_by(&:video_id)
    for i in 0..@workouts.length
      @workout = Workout.new
      @workout.user_id = current_user.id
      @workout.program_id = programs.id
      @workout.day = @workouts[i].day
      @workout.video_id = @workouts[i].video_id
      @workout.created_at = adjusted_start_time
      @workout.save(:validate => false)
    end
    flash[:error] = "You changed programs. Enjoy!"
    redirect_to programs_path
  else
   flash[:error] = "You are already enrolled in this program!"
   redirect_to program_path
 end
end


def list
  @home_page = true
  @programs=Program.all

end

def addcals
  @calorie = Cal.new(:calburnt => params[:calburnt], :created_at => params[:created_at],:user_id => params[:user_id])
  @complete = Workout.find(params[:workout_id])
  @complete.complete = true
  @complete.save
  start_time = @calorie.created_at.to_datetime
  start_time = start_time.in_time_zone(current_user.timezone)
  offset = (start_time.utc_offset)/60/60
  adjusted_start_time = (start_time-offset.hours).utc
  @calorie.created_at = adjusted_start_time
  @calorie.save
  
  respond_to do |format| 
    format.js
  end

end


def nocals
  @complete = Workout.find(params[:workout_id])
  @complete.complete = true
  @complete.save
  respond_to do |format| 
    format.js
  end
end

def show
 @home_page = true
 session[:return_to] = request.url if request.get?
 @user = User.new
 @programs = Program.find(params[:id])
 @workouts = @programs.workouts.order('day').uniq_by(&:day)
 weeks = @workouts.length/7
 # jj=[1,2,2,3,4,4,5,6,6,7]

 # for j in 1..weeks
 #   jj=jj+ jj
 # end

 # @ii=jj
end



def index
	i=0
 @home_page = true
 if signed_in?
  @programs = current_user.workouts
    
   if !@programs.blank?
    program = @programs[0].program_id
    @program = Program.find_by_id(program)
    @log = Log.new
    @latestweight = current_user.weights.where('created_at::date= ?',Date.today.strftime("%Y-%m-%d"))
    @lastweight = current_user.weights.last
    @weight = Weight.new

    session[:return_to] = request.url if request.get?
    videos = current_user.workout_videos.order('day')
    complete = current_user.workouts.order('day')
    day= (((Time.zone.now) - complete[0].created_at)/1.day).floor
    @programday = day + 1
    programday = day + 1

        if programday > 1
           pastvideos = videos[0..programday-2]
        #elsif programday 
        elsif programday > videos.length
          flash[:success] = "You are done with you program. Please, generate a new program!"
          redirect_to new_program_path   
        else
           pastvideos = []
        end
        @todayvideos = [videos[(programday-1)]].compact

    lastvideo = videos[day]
    @findweeks = Program.find_by_id(complete[0].program_id)
    @days = @findweeks.weeks * 7
    @week = (@programday/7.to_f).ceil
    if @week==1
      @videos = videos[0..6]
      @complete = complete[0..6]
      @var = @videos.index(lastvideo)
      # @ii=[1,2,2,3,4,4,5,6,6,7]
    elsif @findweeks.weeks < @week
          flash[:success] = "You are done with you program. Please, generate a new program!"
          redirect_to new_program_path 
    else
      @videos = videos[(@week-1)*7..(@week*7)-1]
      @complete = complete[(@week-1)*7..(@week*7)-1]
      @var = @videos.index(lastvideo)
      # @ii=[1,1,2,3,3,4,5,5,6,7].collect {|n| n +7*(@week-1)}  
    end

  else
  	@program=Program.new
  end
else
  @program=Program.new
end
end

def new
  @program=Program.new
end

def create

  if !current_user.workouts.blank?
  Workout.where(:user_id => current_user.id).delete_all
  Program.where(:user_id => current_user.id).delete_all
  end
  @program = Program.new(prog_params)
  @program.user_id = current_user.id
  @program.created_at = Date.today
  yoga = Video.where(:fitnesstype => "yoga", :duration => @program.time/2..@program.time) if !@program.yoga == false
  pilates = Video.where(:fitnesstype => "pilates", :duration => @program.time/2..@program.time) if !@program.pilates == false
  fat = Video.where(:fitnesstype => "fat burning", :duration => @program.time/2..@program.time) if !@program.fat == false
  strength = Video.where(:fitnesstype => "strength", :duration => @program.time/2..@program.time) if !@program.strength == false
  dance = Video.where(:fitnesstype => "dance",:duration => @program.time/2..@program.time) if !@program.dance == false
  boxing = Video.where(:fitnesstype => "boxing", :duration => @program.time/2..@program.time) if !@program.boxing == false
  hiit = Video.where(:fitnesstype => "high intensity interval training", :duration => @program.time/2..@program.time) if !@program.hiit == false
  barre = Video.where(:fitnesstype => "barre", :duration => @program.time/2..@program.time) if !@program.barre == false
  kettlebell = Video.where(:fitnesstype => "kettlebell", :duration => @program.time/2..@program.time) if !@program.kettlebell == false
  core = Video.where(:fitnesstype => "core",:duration => 3..11)
  coreback = core
  stretching = Video.where(:fitnesstype => "stretching",:duration => 10..60)
  stretchingback = stretching
  videos = [yoga, pilates, strength, dance, barre, boxing, fat, hiit, kettlebell].compact.reduce([], :|)
  videosback = videos
  if videos.length > @program.weeks * 7
    if @program.save
      for i in 1..@program.weeks*7

        if i % 20 == 0
          videos = videosback
          core = coreback
          stretching = stretchingback
        end

        if i % 7 == 0
          stretch = stretching.shuffle.sample
          @workout = Workout.new
          @workout.day = i
          @workout.created_at = Date.today
          @workout.user_id = current_user.id
          @workout.program_id = @program.id
          @workout.video_id = stretch.id
          @workout.save(:validate => false)
          stretching = stretching.select { |h| !stretch.tubeid.include? h['tubeid'] }
        else
          video = videos.shuffle.sample
          @workout = Workout.new
          @workout.day = i
          @workout.user_id = current_user.id
          @workout.created_at = Date.today
          @workout.program_id = @program.id
          @workout.video_id = video.id
          @workout.save(:validate => false)
          blacklist = video
          videos = videos.select { |h| !blacklist.tubeid.include? h['tubeid'] } 
        end

      end
      redirect_to @program

    else
      flash[:error] = "Please, input the program name."
      redirect_to programs_path
    end

  else
    flash[:error] = "Sorry, we don't have enough videos for this program!"
    redirect_to programs_path
  end
end

private
def prog_params    
  params.require(:program).permit(:user_id,:name,:weeks,:time,:fat,:hiit,:core,:pilates,:yoga,:stretching,:strength,:kettlebell,:barre,:dance,:boxing, :created_at, :goal)
end
def require_login
  unless signed_in?
    flash[:error] = "Please, sign up to start your workout plan i"
      redirect_to signup_url # halts request cycle
    end
  end
end
