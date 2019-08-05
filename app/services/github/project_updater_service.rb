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
      )
      repository.project_last_modified = project.updated_at
      repository.users << user if !repository.users.where(id: user.id).any?
      repository.save!
      repository
    end
  end
end
