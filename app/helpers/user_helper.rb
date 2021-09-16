module UserHelper
  def week_kilometers(user)
    Activity.where("day >= ? and user_id = ?", Date.today.beginning_of_week, user.id)
            .sum(:distance)
  end

  def month_kilometers(user)
    Activity.where('day >= ? and user_id = ?', Date.today.beginning_of_month, user.id)
            .sum(:distance)                   
  end

  def month_kilometers_daily(user)
    Activity.where('day >= ? and user_id = ?', Date.today.beginning_of_month, user.id)
            .group(:day)
            .sum(:distance)                   
  end
end