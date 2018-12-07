class SyncrhonizeUsersService
  attr_reader :users

  def initialize(users)
    @users = users
  end

  def perform
    @users.each do |member|
      User.find_or_create_by(url: member.url)
    end

    # deactivate user if existing member in db doesn't exist in the github org anymore
    User.all.each do |member|
      sync_user member
    end
  end

  private
  def sync_user member
    existing_user = @users.select { |user| user.url == member.url }
    if !existing_user
      member.active = false
      member.save!
    end
  end
end
