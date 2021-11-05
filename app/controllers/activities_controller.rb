class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities.order(day: :desc)
  end

  def new
  end
  
  def create
    activity = ActivityServices::ActivityCreator.call(activity_params, current_user)
    if activity.created?
      flash[:notice] = "New activity added"
      redirect_to root_url
    else
      flash[:alert] = activity.payload.errors.full_messages
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