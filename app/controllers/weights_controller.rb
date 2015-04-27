class WeightsController < ApplicationController
  def new
    @home_page = true
    if @weight.blank?
      @weight=Weight.new
    end

  end

  def create
    @weight = Weight.new(weight_params)
    @weight.user_id = current_user.id
    start_time = @weight.created_at.to_datetime
    start_time = start_time.in_time_zone(current_user.timezone)
    offset = (start_time.utc_offset)/60/60
    adjusted_start_time = (start_time-offset.hours).utc
    @weight.created_at = adjusted_start_time
    if @weight.save
      flash[:success] = "Weigh in is complete"
      redirect_to session.delete(:return_to)
    else
      render 'new'
    end
  end

  def update
    @weight = Weight.new(weight_params)
    @weight.user_id = current_user.id
    start_time = @weight.created_at.to_datetime
    start_time = start_time.in_time_zone(current_user.timezone)
    offset = (start_time.utc_offset)/60/60
    adjusted_start_time = (start_time-offset.hours).utc
    @weight.created_at = adjusted_start_time
    if @weight.save
      flash[:success] = "Weigh in is complete"
      redirect_to session.delete(:return_to)
    else
      render 'new'
    end
  end
  private
  def weight_params    
    params.require(:weight).permit(:weight,:user_id,:goalweight, :created_at)
  end
end
