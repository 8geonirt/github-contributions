# frozen_string_literal: true

module Github
  # Class that stores a Github Repository returned by the Github Graphql Server
  class GithubRepository
    attr_reader :name_with_owner, :url, :created_at, :updated_at

    def initialize(repository)
      @name_with_owner = repository.name_with_owner
      @url = repository.url
      @created_at = repository.created_at
      @updated_at = repository.updated_at
    end
  end
end
