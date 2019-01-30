# frozen_string_literal: true

require 'rails_helper'

# TODO: Add description
module Github
  RSpec.describe ProjectUpdaterService do
    subject { ProjectUpdaterService.new(projects.first) }
    include_context 'github_projects'

    context '#perform' do
      describe 'When fetching a project' do
        context 'and project doesn\'t exists in the database' do
          it 'saves the project  in the database' do
            expect do
              subject.perform
            end.to change { Project.count }.by(1)
          end
        end
      end
    end
  end
end
