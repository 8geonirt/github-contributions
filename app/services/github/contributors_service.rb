# frozen_string_literal: true

module Github
  class ContributorsService
    attr_reader :organization, :members

    def initialize(organization)
      @organization = organization
      @members = []
    end

    def perform
      first_cursor = Github::Organization.first_member_cursor(@organization)
      fetch_members first_cursor
      GithubUsers::SyncrhonizeUsersService.new(@members).perform
      GithubUsers::SyncrhonizeRemovedUsersService.new(@members).perform
    end

    private

    def fetch_members(start_cursor)
      organization_members = Github::Organization.members(@organization, start_cursor)
      organization_members.nodes.each { |member| @members << member }
      has_next_page = organization_members.page_info.has_next_page
      next_cursor = organization_members.page_info.end_cursor
      fetch_members next_cursor if has_next_page
    end
  end
end
