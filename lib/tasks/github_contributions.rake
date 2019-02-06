# frozen_string_literal: true

namespace :github_contributions do
  desc 'Github members and their contributions'
  task sync: :environment do
    puts 'Fetching information...'
    GithubMembersWorker.new.perform
    puts 'Done...'
  end
end
