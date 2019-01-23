# frozen_string_literal: true

# A Github repository is considered as a project
module Github
  class ProjectUpdaterService
    attr_reader :project

    def initialize(project)
      @project = project
    end

    def perform
      repository = Project.find_or_create_by(
        name: project.name_with_owner,
        url: project.url,
        project_created_at: project.created_at,
        project_last_modified: project.updated_at
      )
      repository
    end
  end
end
