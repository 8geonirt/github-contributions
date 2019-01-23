# frozen_string_literal: true

shared_context 'github_projects' do
  let(:repository) do
    double('repository',
           url: 'https://github.com/solidus')
  end

  let(:projects) do
    [
        double(
          'project',
          name: 'solidus',
          url: 'https://github.com/solidus',
          name_with_owner: 'solidus/solidus',
          created_at: '2018-09-09',
          updated_at: '2018-09-10',
          repository: repository
        ),
        double(
          'project',
          name: 'shopify',
          url: 'https://github.com/shopify',
          name_with_owner: 'shopify/shopify',
          created_at: '2018-09-09',
          updated_at: '2018-09-10',
          repository: repository
        )
    ]
  end
end
