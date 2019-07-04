# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate!

  def index;
    @users = User.active.order('contributions_count desc')
  end
end
