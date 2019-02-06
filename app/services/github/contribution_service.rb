# frozen_string_literal: true

module Github
  class ContributionService
    attr_reader :member

    def initialize(member)
      @member = member
    end

    def contributions
      first_contribution_cursor = Github::GraphqlQueries::GithubContribution
          .first_contribution_cursor(member.login)
      return unless first_contribution_cursor
      fetch_contributions(first_contribution_cursor)
    end

    def fetch_contributions(start_cursor, contributions = [])
      pull_requests, page_info = github_contributions(start_cursor)
      pull_requests.edges.each do |contribution|
        contributions << GithubContribution.new(contribution.node)
      end

      fetch_contributions(page_info.end_cursor, contributions) if page_info.has_next_page
      contributions
    end

    def github_contributions(start_cursor)
      contributions = Github::GraphqlQueries::GithubContribution
          .contributions(member.login, start_cursor)
      [
          contributions,
          contributions.page_info
      ]
    end
  end
end
