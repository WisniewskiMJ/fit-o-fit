class PagesController < ApplicationController
 before_action :authenticate_user!, only: [:dashboard]

  def welcome
    if user_signed_in?
      redirect_to dashboard_url
    end
  end

  def dashboard
    @user = current_user
  end
end