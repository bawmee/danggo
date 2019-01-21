class Comment < ActiveRecord::Base
    belongs_to :post
    has_many :recomments
    belongs_to :user
end
