class UserPresenter < ApplicationPresenter

  def week_kilometers
    Activity.where("day >= ? and user_id = ?", Date.today.beginning_of_week, @model.id)
            .sum(:distance)
  end

  def month_kilometers
    Activity.where('day >= ? and user_id = ?', Date.today.beginning_of_month, @model.id)
            .sum(:distance)                   
  end

  def month_kilometers_daily
    Activity.where('day >= ? and user_id = ?', Date.today.beginning_of_month, @model.id)
            .group(:day)
            .sum(:distance)                   
  end
end