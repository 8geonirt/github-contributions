# frozen_string_literal: true

module GithubUsers
  class SyncrhonizeUsersService
    attr_reader :users

    def initialize(users)
      @users = users
    end

    def perform
      @users.each do |member|
        user = User.find_or_initialize_by(login: member.login)
        user.update_attributes({
          avatar_url: member.avatar_url,
          username: member.name,
          email: member.email
        })
      end
    end
  end
end
