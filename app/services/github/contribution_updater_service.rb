# frozen_string_literal: true

# A Github repository is considered as a project
module Github
  class ContributionUpdaterService
    attr_reader :contribution, :project

    def initialize(contribution, project)
      @contribution = contribution.meta
      @project = project
    end

    def perform
      Contribution.find_or_create_by(
        pull_request_url: contribution[:url],
        repository: contribution[:repository].url,
        closed_merged_at: contribution[:merged_at],
        user: User.find_by(login: contribution[:author]),
        project: project,
        title: contribution[:title],
        body_html: contribution[:body_html]
      )
    end
  end
end
