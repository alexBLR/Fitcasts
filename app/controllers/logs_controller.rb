class LogsController < ApplicationController
  before_action :require_login, only: [:index, :new]
  def index
    @home_page = true
    session[:return_to] = request.url if request.get?
    
    if !current_user.log.blank?
     @calorie = current_user.cals
     if !@calorie.blank?
       @currentcal = current_user.cals.last.calburnt
       @averagecal = current_user.cals.average(:calburnt)
     else
      @currentcal = 0
      @averagecal = 0
    end
    
    @logs=Weight.where(user_id: current_user.id)
    @log=current_user.log
    @currentweight=current_user.weights.last.weight
    @bmi = (@currentweight.to_f*703)/((@log.height*12)+@log.height2)**2
    
    if @log.sex == 'man' || @log.sex== 'male'
      @bmr = 66 + (6.23*@log.weight) + (12.7*((@log.height*12)+@log.height2)) - (6.8*@log.age)
    else
      @bmr = 655 + (4.35*@log.weight) + (4.7*((@log.height*12)+@log.height2)) - (4.7*@log.age)
    end
    
    @startweight = current_user.log.weight
    @change = @currentweight - @startweight
    @percentchange = (@change.to_f / @startweight)*100
    
    else
    	@log = Log.new
    end
  end

def new
  @home_page = true
  @log = Log.new
end

def create
  @weight = Weight.new
  @calorie =Cal.new
  @log = Log.new(log_params)
  @log.user_id = current_user.id
  @weight.user_id = current_user.id
  @weight.weight = @log.weight
  @weight.goalweight = @log.goalweight
  start_time = Time.zone.now.to_datetime
  start_time = start_time.in_time_zone(current_user.timezone)
  offset = (start_time.utc_offset)/60/60
  adjusted_start_time = (start_time-offset.hours).utc
  @log.created_at = adjusted_start_time
  @weight.created_at = adjusted_start_time
  if @log.save 
    @weight.save(:validate => false)
    flash[:success] = "Assessment is added"
    redirect_to session.delete(:return_to)
  else
    render 'new'
  end
end

private
def log_params    
  params.require(:log).permit(:sex,:user_id,:height,:weight,:age,:goalweight, :created_at, :height2)
end

def require_login
  unless signed_in?
    flash[:error] = "You must be logged in to access this section"
      redirect_to signin_url # halts request cycle
    end
  end
end
