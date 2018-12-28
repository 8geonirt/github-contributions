# frozen_string_literal: true

require 'graphql/client'

module GithubServices
  # Module to execute Graphql queries
  module GraphqlService
    URL = 'https://api.github.com/graphql'
    auth_token = Rails.application.credentials.access[:github_access_token]
    HttpAdapter = CustomHTTP.new(URL, auth_token)
    Schema = GraphQL::Client.load_schema(HttpAdapter)
    Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)
  end
end
