class ContributionsController < ApplicationController
  before_action :authenticate!
  before_action :user, only: [:index]

  def index
    @project = user.projects.find_by(id: params[:project_id])
    @contributions = @project.contributions.where(user_id: user.id).order('closed_merged_at desc')
  end

  private

  def user
    User.find(session[:current_user_id])
  end
end
