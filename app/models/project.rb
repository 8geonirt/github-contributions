# frozen_string_literal: true

# Class that will perform CRUD operations to the Projects table
class Project < ApplicationRecord
  has_many :contributions
  has_and_belongs_to_many :users
  validates :name, :url, presence: true
end
