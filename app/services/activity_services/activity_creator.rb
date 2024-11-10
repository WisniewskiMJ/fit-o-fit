module ActivityServices
  class ActivityCreator < ApplicationService
    def initialize(params:, user:)
      @start_address = params[:start_address]
      @finish_address = params[:finish_address]
      @day = params[:day]
      @user = user
    end

    def call
      start = Place.find_by(address: formatted_address(start_address)) || PlaceServices::PlaceCreator.call(address: formatted_address(start_address)).payload
      finish = Place.find_by(address: formatted_address(finish_address)) || PlaceServices::PlaceCreator.call(address: formatted_address(finish_address)).payload

      if start.persisted? && finish.persisted? && @day.present?
        activity = @user.activities.build(start_id: start.id, finish_id: finish.id, day: @day)
        activity.distance = ActivityServices::DistanceFinder.call(start_point: start, finish_point: finish)
        activity.save
        OpenStruct.new({ created?: true, payload: activity })
      else
        activity = Activity.new
        activity.errors.add :start, :start_address, message: start.errors.full_messages unless start.persisted?
        activity.errors.add :finish, :finish_address, message: finish.errors.full_messages unless finish.persisted?
        activity.errors.add :day, :day_blank, message: 'can`t be blank!' unless @day.present?
        OpenStruct.new({ created?: false, payload: activity })
      end
    end

    private

    attr_reader :start_address, :finish_address

    def formatted_address(address)
      address.split(',').map(&:strip).join(', ')
    end
  end
end
