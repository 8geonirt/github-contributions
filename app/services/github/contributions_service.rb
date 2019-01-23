# frozen_string_literal: true

module Github
  class ContributionsService
    attr_reader :contributions

    def initialize
      @contributions = []
    end

    def perform
      User.all.each do |member|
        has_contributions =
          Github::GraphqlQueries::GithubContribution.contributions?(member.login)
        next unless has_contributions
        first_contribution_cursor =
          Github::GraphqlQueries::GithubContribution.first_contribution_cursor(member.login)
        fetch_contributions(member, first_contribution_cursor) if first_contribution_cursor
        Github::ProjectsService.new(contributions).perform
        @contributions = []
      end
    end

    private

    # :reek:FeatureEnvy
    def fetch_contributions(member, start_cursor)
      github_contributions = Github::GraphqlQueries::GithubContribution
          .contributions(member.login, start_cursor)

      github_contributions.edges.each do |contribution|
        @contributions << GithubContribution.new(contribution.node)
      end

      has_next_page = github_contributions.page_info.has_next_page
      next_cursor = github_contributions.page_info.end_cursor
      fetch_contributions(member, next_cursor) if has_next_page
    end
  end
end
