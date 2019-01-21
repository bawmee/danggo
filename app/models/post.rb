class Post < ActiveRecord::Base
    acts_as_votable
    has_many :comments
    has_many :scraps
    belongs_to :user
end
# @post = Post.new
# @post.save

# @post.liked_by @user
# @post.votes_for.size # => 1