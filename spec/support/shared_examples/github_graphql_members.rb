shared_context 'github_members' do
  let(:users) do
    [
      double('member' , {
        login: 'a@a.com',
        avatar_url: 'something.com',
        name: 'a_member',
        email: 'a@a.com'
      }),
      double('member' , {
        login: 'existing@a.com',
        avatar_url: 'existing_avatar.com',
        name: 'existing_member',
        email: 'existing@a.com'
      }),
    ]
  end
end
