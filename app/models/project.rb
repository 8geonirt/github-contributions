class Project < ApplicationRecord
  has_many :contributions
  has_and_belongs_to_many :users
  validates :name, :url, presence: true
end