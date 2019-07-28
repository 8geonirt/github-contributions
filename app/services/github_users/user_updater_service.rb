# frozen_string_literal: true

module GithubUsers
  class UserUpdaterService
    attr_reader :member

    def initialize(member)
      @member = member.meta
    end

    def perform
      user = User.find_or_initialize_by(login: @member[:login])
      user.update_attributes(
        avatar_url: @member[:avatar_url],
        username: @member[:name],
        email: @member[:email],
        active: true
      )
    end
  end
end
