# frozen_string_literal: true

# Class that will perform CRUD operations to the Contributions table
class Contribution < ApplicationRecord
  belongs_to :project
  belongs_to :user, counter_cache: true

  validates :repository, :pull_request_url, presence: true
end
