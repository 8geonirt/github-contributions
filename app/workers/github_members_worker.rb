# frozen_string_literal: true

# Fetch the members of an organization
class GithubMembersWorker
  def perform
    Github::MembersService.new('magma-labs').perform
    ContributionsWorker.new.perform
  end
end
