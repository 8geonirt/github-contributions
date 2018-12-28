# frozen_string_literal: true

# Class that will perform CRUD operations to the Users table
# For logging in users, it will allow only users that exist in the current Github Organization
class User < ApplicationRecord
  has_and_belongs_to_many :projects
  has_many :contributions

  def self.from_omniauth(auth)
    auth_info = auth.info
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth_info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.avatar_url = auth_info.image
      user.username = auth_info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
