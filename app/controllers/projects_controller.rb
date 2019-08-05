class ProjectsController < ApplicationController
  before_action :authenticate!
  before_action :set_user, only: [:index]

  def index
    @projects = @user.projects.joins(:contributions)
      .where('contributions.user_id': @user.id)
      .group('projects.id')
      .order('COUNT(contributions.id) desc')
      .select('name, projects.id, count(contributions.id) as total_contributions')
  end

  private

  def set_user
    @user = User.find(params[:user_id])
    session[:current_user_id] = @user.id
  end
end
