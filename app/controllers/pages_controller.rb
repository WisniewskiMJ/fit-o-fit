class PagesController < ApplicationController
  def welcome
    if user_signed_in?
      redirect_to dashboard_url
    end
  end

  def dashboard
    @user = current_user
  end
end