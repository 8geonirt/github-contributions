# frozen_string_literal: true

module Github
  module GraphqlQueries
    # Class that stores the GraphqlQuery to fetch Members of an organization
    class Organization
      MembersQuery = GithubServices::GraphqlService::Client.parse <<-'GRAPHQL'
      query($organization: String!, $afterCursor: String!) {
          organization(login: $organization) {
            login
            members(first: 10, after: $afterCursor) {
              nodes {
                company
                avatarUrl
                id
                login
                url
                email
                name
              }
              pageInfo {
                endCursor
                startCursor
                hasNextPage
              }
              totalCount
            }
          }
        }
      GRAPHQL

      FirstMemberQuery = GithubServices::GraphqlService::Client.parse <<-'GRAPHQL'
      query($organization: String!) {
          organization(login: $organization) {
            login
            members(first: 1) {
              nodes {
                company
                avatarUrl
                login
                id
                url
                email
                name
              }
              pageInfo {
                startCursor
              }
            }
          }
        }
      GRAPHQL

      def self.first_member_cursor(organization)
        variables = { organization: organization }
        response = GithubServices::GraphqlService::QueryExecutor
            .new(FirstMemberQuery, variables).perform
        response.organization.members.page_info.start_cursor
      end

      def self.members(organization, cursor)
        variables = {
            organization: organization,
            afterCursor: cursor
        }
        response = GithubServices::GraphqlService::QueryExecutor
            .new(MembersQuery, variables).perform
        response.organization.members
      end
    end
  end
end
