# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Croutons::Controller
  helper_method :current_user, :signed_in?

  def current_user
    session[:user_id].present? ? User.find(session[:user_id]) : nil
  end

  def signed_in?
    current_user != nil
  end

  def authenticate!
    if !signed_in?
      redirect_to login_path
    end
  end
end
