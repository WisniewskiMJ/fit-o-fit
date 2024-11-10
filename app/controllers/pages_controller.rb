class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def welcome
    return unless user_signed_in?

    redirect_to dashboard_url
  end

  def dashboard
    @user = current_user
  end
end
