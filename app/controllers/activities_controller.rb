class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities
  end

  def new
  end
  
  def create
    start_address = activity_params[:start_address]
    finish_address = activity_params[:finish_address]
    day = activity_params[:day]

    start = Place.find_or_initialize_by(address: activity_params[:start_address])
    finish = Place.find_or_initialize_by(address: activity_params[:finish_address])
   
    if !start.valid?
      flash[:danger] = "Enter a valid start address using correct format!"
      redirect_to new_activity_url and return
    elsif !finish.valid?
      flash[:danger] = "Enter a valid finish address using correct format!"
      redirect_to new_activity_url and return
    end

    start.save
    finish.save

    @activity = current_user.activities.build(start_id: start.id, finish_id: finish.id, day: day)
    if @activity.save
      flash[:success] = "New activity added"
      redirect_to root_url
    else
      flash[:danger] = "Day can't be blank"
      redirect_to new_activity_url
    end

  end

  def show
    @activity = Activity.find_by(id: params[:id])
  end

  def destroy
  end

  private

  def activity_params
    params.require(:activity).permit(:start_address, :finish_address, :day)
  end

end