class ContributionsController < ApplicationController
  before_action :authenticate!
  before_action :set_user, only: [:index]

  def index
    @projects = @user.projects.map {|p| {project: p, contributions: p.contributions.where(user_id: @user.id)}}
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
