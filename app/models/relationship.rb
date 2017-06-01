class Relationship < ActiveRecord::Base
  belongs_to :follower, foreign_key: "follower_id"
  belongs_to :followed, foreign_key: "followed_id"
end
