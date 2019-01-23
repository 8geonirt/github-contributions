# frozen_string_literal: true

module Github
  class ProjectsService
    attr_reader :projects, :contributions

    def initialize(contributions)
      @projects = []
      @contributions = contributions
    end

    def perform
      contributions.each do |contribution|
        project = Github::ProjectUpdaterService.new(contribution.meta[:repository]).perform
        Github::ContributionUpdaterService.new(contribution, project).perform
      end
    end
  end
end
