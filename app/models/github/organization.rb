class QueryExecutionError < StandardError; end

module Github
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
      if response.errors.any?
        raise QueryExecutionError.new(response.errors[:data].join(", "))
      else
        response.data.organization.members.page_info.start_cursor
      end
    end

    def self.members(organization, cursor)
      response = GithubServices::GraphqlService::Client.query(MembersQuery, variables: {
        organization: organization,
        afterCursor: cursor
      })
      if response.errors.any?
        raise QueryExecutionError.new(response.errors[:data].join(", "))
      else
        response.data.organization.members
      end
    end
  end
end
