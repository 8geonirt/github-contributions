# frozen_string_literal: true

module GithubUsers
  class SyncrhonizeRemovedUsersService
    attr_reader :users

    def initialize(users)
      @users = users
    end

    def perform
      logins = @users.map(&:login)
      User.where.not(login: logins).update_all(active: false)
    end
  end
end
