class CalsController < ApplicationController
  def new
  	@home_page = true
  	@calorie=Cal.find_by_user_id(current_user.id)
  	if @calorie.blank?
  		@calorie=Cal.new
  	end
  end
  def create

    @calorie = Cal.new(calorie_params)
    @calorie.user_id = current_user.id
    start_time = @calorie.created_at.to_datetime
    start_time = start_time.in_time_zone(current_user.timezone)
    offset = (start_time.utc_offset)/60/60
    adjusted_start_time = (start_time-offset.hours).utc
    @calorie.created_at = adjusted_start_time
    if @calorie.save
      flash[:success] = "Calories burned is updated"
      redirect_to logs_path
    else
      render 'new'
    end
  end


  def update
    @calorie = Cal.new(calorie_params)
    @calorie.user_id = current_user.id
    start_time = @calorie.created_at.to_datetime
    start_time = start_time.in_time_zone(current_user.timezone)
    offset = (start_time.utc_offset)/60/60
    adjusted_start_time = (start_time-offset.hours).utc
    @calorie.created_at = adjusted_start_time
    if @calorie.save
      flash[:success] = "Calories burned is updated"
      redirect_to logs_path
    else
      render 'new'
    end
  end
  private
  def calorie_params    
    params.require(:cal).permit(:calburnt,:user_id, :created_at)
  end

end
