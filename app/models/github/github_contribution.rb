# frozen_string_literal: true

module Github
  # Class to store a Github contribution from the Github Graphql Server
  class GithubContribution
    attr_reader :meta

    # :reek:FeatureEnvy
    def initialize(contribution)
      @meta = {
          author: contribution.author.login,
          title: contribution.title,
          url: contribution.url,
          updated_at: contribution.updated_at,
          merged_at: contribution.merged_at,
          merged_by: contribution.merged_by,
          repository: GithubRepository.new(contribution.repository)
      }
    end
  end
end
