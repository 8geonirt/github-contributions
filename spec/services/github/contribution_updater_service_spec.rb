# frozen_string_literal: true

require 'rails_helper'

# TODO: Add description
module Github
  RSpec.describe ContributionUpdaterService do
    let(:user) { User.find_or_create_by(login: 'softr8') }
    let(:project) { ProjectUpdaterService.new(contributions.first.meta[:repository], user).perform }
    subject { ContributionUpdaterService.new(contributions.first, project) }
    include_context 'github_contributions'

    context '#perform' do
      describe 'When fetching a contribution' do
        context 'and contribution doesn\'t exists in the database' do
          it 'saves the contribution in the database' do
            expect do
              subject.perform
            end.to change { Contribution.count }.by(1)
          end
        end
      end
    end
  end
end
