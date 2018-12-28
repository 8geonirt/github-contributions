# frozen_string_literal: true

module GithubUsers
  class SyncrhonizeUsersService
    attr_reader :users

    def initialize(users)
      @users = users
    end

    def perform
      @users.each do |member|
        GithubUsers::UserUpdaterService.new(member).perform
      end
    end
  end
end
