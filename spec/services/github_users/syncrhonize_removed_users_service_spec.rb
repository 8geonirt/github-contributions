# frozen_string_literal: true

require 'rails_helper'

# Spec that checks if an user was removed from the organization, if so then it will be mark
# as inactive in the database
module GithubUsers
  RSpec.describe SyncrhonizeRemovedUsersService do
    subject { SyncrhonizeRemovedUsersService.new(users) }
    include_context 'github_members'

    context '#perform' do
      describe 'when users are removed from the org' do
        it 'also deactivates them from this system' do
          User.create(login: 'a@a.com')
          User.create(login: 'deleted@a.com')
          expect do
            subject.perform
          end.to change { User.active.count }.by(-1)
        end
      end
    end
  end
end
