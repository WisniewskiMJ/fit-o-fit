class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def new
  end
  
  def create
    start_address = params[:activity][:start_address]
    finish_address = params[:activity][:finish_address]
    day = params[:activity][:day]

    start = Place.find_by(address: start_address)
    start ||= Place.new(address: start_address)
   
    if !start.valid?
      flash[:warning] = "Enter a valid start address using correct format!"
      redirect_to :new
    end

    finish = Place.find_by(address: finish_address)
    finish ||= Place.new(address: finish_address)

    if !finish.valid?
      flash[:warning] = "Enter a valid finish address using correct format!"
      redirect_to :new
    end

    start.save
    finish.save

    @activity = current_user.activities.build(start_id: start.id, finish_id: finish.id, day: day)
    
    if @activity.save
      flash[:success] = "New activity added"
      redirect_to @activity
    else
      flash[:warning] = "Could not add new activity. Check if parameters are valid"
      redirect_to :new 
    end

  end

  def show
  end

  def destroy
  end

end