# frozen_string_literal: true

# A Github repository is considered as a project
module Github
  class ProjectUpdaterService
    attr_reader :project
    attr_reader :user

    def initialize(project, user)
      @project = project
      @user = user
    end

    def perform
      repository = Project.find_or_create_by(
        name: project.name_with_owner,
        url: project.url,
        project_created_at: project.created_at
      ) do |current_repository|
        current_repository.project_last_modified = project.updated_at
        current_repository.users << user if !current_repository.users.where(id: user.id).any?
        current_repository.save!
      end
      repository
    end
  end
end
