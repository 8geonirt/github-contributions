# frozen_string_literal: true

module Github
  module GraphqlQueries
    # Queries for the Github GraphQL to get members' contributions
    class GithubContribution
      ContributionsQuery = GithubServices::GraphqlService::Client.parse <<-'GRAPHQL'
      query ($member: String!, $afterCursor: String!) {
        user(login: $member) {
          name
          login
          company
          url
          pullRequests(states: MERGED, first: 10, after: $afterCursor, orderBy: {direction: DESC, field: UPDATED_AT}) {
            pageInfo {
              endCursor
              startCursor
              hasNextPage
            }
            totalCount
            edges {
              node {
                author {
                  login
                }
                repository {
                  nameWithOwner
                  url
                  createdAt
                  updatedAt
                }
                title
                url
                updatedAt
                mergedAt
                mergedBy {
                  login
                }
              }
            }
          }
        }
      }
      GRAPHQL

      FirstContributionQuery = GithubServices::GraphqlService::Client.parse <<-'GRAPHQL'
      query ($member: String!) {
        user(login: $member) {
          pullRequests(states: MERGED, first: 1, orderBy: {direction: DESC, field: UPDATED_AT}) {
            pageInfo {
              startCursor
            }
          }
        }
      }
      GRAPHQL

      TotalContributionsQuery = GithubServices::GraphqlService::Client.parse <<-'GRAPHQL'
      query ($member: String!) {
        user(login: $member) {
          pullRequests(states: MERGED, first: 1, orderBy: {direction: DESC, field: UPDATED_AT}) {
            totalCount
          }
        }
      }
      GRAPHQL

      def self.first_contribution_cursor(member)
        variables = { member: member }
        response = GithubServices::GraphqlService::QueryExecutor
            .new(FirstContributionQuery, variables).perform
        response.user.pull_requests.page_info.start_cursor
      end

      def self.total_contributions(member)
        variables = { member: member }
        response = GithubServices::GraphqlService::QueryExecutor
            .new(TotalContributionsQuery, variables).perform
        response.user.pull_requests.total_count
      end

      def self.contributions(member, cursor)
        variables = {
            member: member,
            afterCursor: cursor
        }
        response = GithubServices::GraphqlService::QueryExecutor
            .new(ContributionsQuery, variables).perform
        response.user.pull_requests
      end

      def self.contributions?(member)
        total_contributions(member).positive?
      end
    end
  end
end
