# frozen_string_literal: true

require 'rails_helper'

# Spec that checks if an new user was added to the organization, if so then it will be added
# to the database in case it doesn't exist, if it exists it will update the attributes
module GithubUsers
  RSpec.describe SyncrhonizeUsersService do
    subject { SyncrhonizeUsersService.new(users) }
    include_context 'github_members'

    context '#perform' do
      describe 'When fetching a member' do
        context 'and member doesn\'t exists in the database' do
          before do
            User.create(login: 'existing@a.com')
          end
          it 'saves the record in the database' do
            expect do
              subject.perform
            end.to change { User.count }.by(1)
          end
        end
      end
    end
  end
end
