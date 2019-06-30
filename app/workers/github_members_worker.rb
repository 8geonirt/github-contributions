# frozen_string_literal: true

# Fetch the members of an organization
class GithubMembersWorker
  def self.perform
    Github::MembersService.new('magma-labs').perform
    ContributionsWorker.perform
  end
end
