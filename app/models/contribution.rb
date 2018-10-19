class Contribution < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :repository, :pull_request_url, presence: true
end
