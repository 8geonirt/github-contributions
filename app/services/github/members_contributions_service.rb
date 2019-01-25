# frozen_string_literal: true

module Github
  class MembersContributionsService
    attr_reader :member

    def initialize(member)
      @member = member
    end

    def perform
      ContributionService.new(member).contributions.each do |contribution|
        project = Github::ProjectUpdaterService.new(contribution.meta[:repository]).perform
        Github::ContributionUpdaterService.new(contribution, project).perform
      end
    end
  end
end
