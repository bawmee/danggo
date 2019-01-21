class User < ActiveRecord::Base
  acts_as_voter
  
  has_many :posts
  has_many :comments
  has_many :recomments
  has_many :scraps
  def is_scrap?(post) 
    Scrap.find_by(user_id: self.id, post_id: post.id).present? 
  end
  has_many :points
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
end
