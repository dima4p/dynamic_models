class StaticController < ApplicationController

  layout 'static'
  
  before_filter :set_user_data

  def risk_report
  end

  def efficiency
  end

  private

  def set_user_data
    @user_name = 'Dmitri Ivanov'
    @user_pic = 'ivanov.jpg'
  end

end
