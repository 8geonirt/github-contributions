# frozen_string_literal: true

module Github
  # Class that stores a Github member returned by the Github Graphql Server
  class GithubMember
    attr_reader :meta

    # :reek:FeatureEnvy
    def initialize(member)
      @meta = {
          company: member.company,
          avatar_url: member.avatar_url,
          login: member.login,
          url: member.url,
          email: member.email
      }
    end
  end
end
