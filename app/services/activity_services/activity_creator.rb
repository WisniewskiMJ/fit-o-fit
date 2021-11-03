module ActivityServices
  class ActivityCreator < ApplicationService
    def initialize(params, user)
      @start_address = params[:start_address]
      @finish_address = params[:finish_address]
      @day = params[:day]
      @user = user
    end

    def call
      start = Place.find_by(address: @start_address) || PlaceServices::PlaceCreator.call(@start_address)
      finish = Place.find_by(address: @finish_address) || PlaceServices::PlaceCreator.call(@finish_address)
    
      if start.persisted? && finish.persisted? && @day.present?
        activity = @user.activities.build(start_id: start.id, finish_id: finish.id, day: @day)
        activity.distance = ActivityServices::DistanceFinder.call(@start_address, @finish_address)
        activity.save
        result = OpenStruct.new({created?: true, payload: activity})
      else
        activity = Activity.new
        activity.errors.add :start, :start_address, message: start.payload.errors.full_messages if !start.valid?
        activity.errors.add :finish, :finish_address, message: finish.payload.errors.full_messages if !finish.valid?
        activity.errors.add :day, :day_blank, message: "can`t be blank!" if !@day.present?
        result = OpenStruct.new({created?: false, payload: activity})
      end
    end
  end
end