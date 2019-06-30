# frozen_string_literal: true

require 'graphql/client'

module GithubServices
  # Custom class for query execution errors
  class QueryExecutionError < StandardError; end

  # Module to execute Graphql queries
  module GraphqlService
    URL = 'https://api.github.com/graphql'
    auth_token = Rails.application.credentials.access[:github_access_token]
    HttpAdapter = CustomHTTP.new(URL, auth_token)
    Schema = GraphQL::Client.load_schema(HttpAdapter)
    Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)

    # Wrapper to run Graphql Queries
    class QueryExecutor
      attr_reader :query, :variables

      def initialize(query, variables)
        @query = query
        @variables = variables
      end

      def perform
        response = Client.query(query, variables: variables)
        raise QueryExecutionError response.errors[:data].join(', ') if response.errors.any?
        response.data
      end
    end
  end
end
