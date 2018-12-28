# frozen_string_literal: true

# This class is going to make all the models using ActiveRecord to extend
# from this and also saying that the class should be abstract. If we want to add new ActiveRecord
# features we can do it in this file
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
