class Comment < ActiveRecord::Base
  
  belongs_to :button
  belongs_to :user

  # Validations
  validates_presence_of :body
  validates_presence_of :user
end
