require 'graphql/client'
require 'graphql/client/http'

module GithubServices
  module GraphqlService
    URL = 'https://api.github.com/graphql'
    HttpAdapter = GraphQL::Client::HTTP.new(URL) do
      def headers(context)
        {
          'Authorization' => "Bearer #{Rails.application.credentials.access[:github_access_token]}",
          'User-Agent' => 'Ruby'
        }
      end
    end
    Schema = GraphQL::Client.load_schema(HttpAdapter)
    Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)
  end
end
