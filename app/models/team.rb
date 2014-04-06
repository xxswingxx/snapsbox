class Team < ActiveRecord::Base
  # Associations
  has_many :users
  has_many :buttons
  
  # Validations
  validate :name, presence: true
end
