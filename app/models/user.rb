# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :projects
  has_many :contributions

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.avatar_url = auth.info.image
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
