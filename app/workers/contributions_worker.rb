# frozen_string_literal: true

# Fetch contributions only for active members of the organization
class ContributionsWorker
  def self.perform
    User.active.each do |member|
      next unless Github::GraphqlQueries::GithubContribution.contributions?(member.login)
      Github::MembersContributionsService.new(member).perform
    end
  end
end
