class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user 


  validates :comment, presence: true, profanity_filter: true
end
