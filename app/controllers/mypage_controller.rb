class MypageController < ApplicationController
  def mypage
   
    @posts = current_user.posts.reverse
    @scraps = current_user.scraps.reverse
    @comments = current_user.comments.reverse
    @recomments = current_user.recomments.reverse
    @points = Point.where("user_id = ? ", current_user.id).reverse
     
  
  end
end
