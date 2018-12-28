# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    session[:user_id].present? ? User.find(session[:user_id]) : nil
  end
end
