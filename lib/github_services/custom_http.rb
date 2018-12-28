# frozen_string_literal: true

require 'graphql/client/http'

module GithubServices
  # Custom HTTP Adapters for GraphQL
  class CustomHTTP < GraphQL::Client::HTTP
    attr_reader :uri, :auth_token

    def initialize(uri, auth_token)
      @uri = URI.parse(uri)
      @auth_token = auth_token
    end

    def headers(_context)
      {
          'Authorization': "Bearer #{auth_token}",
          'User-Agent': 'Ruby'
      }
    end
  end
end
