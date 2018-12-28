# frozen_string_literal: true

# Custom class for query execution errors
class QueryExecutionError < StandardError; end

module Github
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
      response = GithubServices::GraphqlService::Client.query(FirstMemberQuery, variables: {
                                                                  organization: organization
                                                              })
      raise QueryExecutionError response.errors[:data].join(', ') if response.errors.any?
      response.data.organization.members.page_info.start_cursor
    end

    def self.members(organization, cursor)
      response = GithubServices::GraphqlService::Client.query(MembersQuery, variables: {
                                                                  organization: organization,
                                                                  afterCursor: cursor
                                                              })
      raise QueryExecutionError response.errors[:data].join(', ') if response.errors.any?
      response.data.organization.members
    end
  end
end
