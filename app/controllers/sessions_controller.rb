# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])

    if !User.active.find_by(login: user.username)
      return redirect_to login_path
    end
    return unless user.valid?
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
