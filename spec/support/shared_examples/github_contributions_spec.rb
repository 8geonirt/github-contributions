# frozen_string_literal: true

shared_context 'github_contributions' do
  let(:repository) do
    double(
      'project',
      name: 'solidus',
      url: 'https://github.com/solidus',
      name_with_owner: 'solidus/solidus',
      created_at: '2018-09-09',
      updated_at: '2018-09-10'
    )
  end

  let(:contributions) do
    [
        double(
          'contribution',
          meta: {
              'author': 'softr8',
              'title': 'Allowing admin to show all countries regardless checkout zone',
              'url': 'https://github.com/solidusio/solidus/pull/2588',
              'repository': repository,
              'merged_at': '2018-02-26T22:55:25Z',
              'merged_by': {
                  'login': 'jhawthorn'
              }
          }
        ),
        double(
          'contribution',
          meta: {
              'author': 'softr8',
              'title': 'Making sure order by columns do not collide with other tables',
              'url': 'https://github.com/solidusio/solidus/pull/2774',
              'repository': repository,
              'merged_at': '2018-06-29T13:29:26Z',
              'merged_by': {
                  'login': 'gmacdougall'
              }
          }
        )
    ]
  end
end
