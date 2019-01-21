class BoardController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all.reverse
  end
  
  def detail
    @post = Post.find(params[:post_id])
    @ttl = @post.created_at + 32400
    @uv = @post.get_upvotes.voters
    @dv = @post.get_downvotes.voters
  end
  
  def food
    @foods =  Post.where("category = ?", "food").reverse
  end
  
  def fashion
    @fashions =  Post.where("category = ?", "fashion").reverse
  end

  def love
    @loves =  Post.where("category = ?", "love").reverse
  end

  def new
  end

  def create
    @post = Post.new
    @post.category = params[:category]
    if @post.category == "food"
      @post.color = "#FAC564"
    elsif @post.category == "fashion"
      @post.color = "#85C8C5"
    elsif @post.category == "love"
      @post.color = "#FF9763"
    end
    @post.title = params[:title]
    @post.content = params[:content]
    @post.user_id = current_user.id
    @post.name = current_user.name
    @post.time = params[:vote_time]
    @post.vote = 0;
    
    
    file = params[:pic]
    uploader = AvatarUploader.new
    uploader.store!(file)
    @post.image_url = uploader.url
    @post.save
    redirect_to '/board/index'
  end

  def edit
    @post = Post.find(params[:post_id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @post.category = params[:category]
    if @post.category == "food"
      @post.color = "red"
    elsif @post.category == "fashion"
      @post.color = "orange"
    elsif @post.category == "love"
      @post.color = "LightSkyBlue"
    end
    @post.vote_type = params[:vote_type]
    @post.time = params[:vote_time]
    @post.title = params[:title]
    @post.content = params[:content]
    
    
    file = params[:pic]
    uploader = AvatarUploader.new
    uploader.store!(file)
    @post.image_url = uploader.url
    @post.save
    redirect_to "/board/detail/#{@post.id}"
  end
  
  def delete
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect_to '/board/index'
  end
  
  
  def comment_create
        @post = Post.find(params[:post_id])
        @comment = Post.find(params[:post_id]).comments.create
        @comment.content = params[:comment_content]
        @comment.user_id = current_user.id
        @comment.name = current_user.name
        @comment.save
        
        redirect_to "/board/detail/#{@post.id}"
  end
  
  def comment_update
        @post = Post.find(params[:post_id])
        @comment = Post.find(params[:post_id]).comments.find(params[:comment_id])
        @comment.content = params[:comment_content]
        @comment.save
    
        redirect_to "/board/detail/#{@post.id}"
  end
  
  def comment_edit
        @post = Post.find(params[:post_id])
        @comment = Post.find(params[:post_id]).comments.find(params[:comment_id])
  end
  
  def comment_destroy
        @post = Post.find(params[:post_id])
        @comment = Post.find(params[:post_id]).comments.find(params[:comment_id])
        @comment.destroy
    
        redirect_to "/board/detail/#{@post.id}"
    end
  
  def recomment_create
      @post = Post.find(params[:post_id])
      @comment= Post.find(params[:post_id]).comments.find(params[:comment_id])
      @recomment = @comment.recomments.create
      @recomment.content = params[:recomment_content]
      @recomment.user_id = current_user.id
      @recomment.name = current_user.name
      @recomment.save
    
    redirect_to "/board/detail/#{@post.id}"
  end
  
  def recomment_destroy
        @post = Post.find(params[:post_id])
        @recomment = Post.find(params[:post_id]).comments.find(params[:comment_id]).recomments.find(params[:recomment_id])
        @recomment.destroy
    
        redirect_to "/board/detail/#{@post.id}"
  end
    
  def recomment_update
        @post = Post.find(params[:post_id])
        @recomment = Post.find(params[:post_id]).comments.find(params[:comment_id]).recomments.find(params[:recomment_id])
        @recomment.content = params[:recomment_content]
        @recomment.save
    
        redirect_to "/board/detail/#{@post.id}"
  end
  
  def recomment_edit
      @post = Post.find(params[:post_id])
      @comment = Post.find(params[:post_id]).comments.find(params[:comment_id])
      @recomment = Post.find(params[:post_id]).comments.find(params[:comment_id]).recomments.find(params[:recomment_id])
  end
  
  
  
# 투표 관련 Controller 내용 : 찬성
def upvote
    @post = Post.find(params[:id])

    #만약 '찬성' 투표를 이미 한 경우 : '찬성' 투표 취소
    if ((current_user.voted_up_on? @post) == true)
        @post.unliked_by current_user
        #redirect_to(request.referrer, :notice => '해당 글의 추천을 취소하셨습니다.')
        
    else
        @post.upvote_by current_user
        #redirect_to(request.referrer, :notice => '해당 글을 추천하셨습니다.')
       
    end
    redirect_to :back
end

# 투표 관련 Controller 내용 : 반대
def downvote
    @post = Post.find(params[:id])
    #만약 '반대' 투표를 이미 한 경우 : '반대' 투표 취소
    if ((current_user.voted_down_on? @post) == true)
        @post.unliked_by current_user    
        #redirect_to(request.referrer, :notice => '해당 글의 반대를 취소하셨습니다.')
        
    else
        @post.downvote_from current_user
        #redirect_to(request.referrer, :notice => '해당 글을 반대하셨습니다.')
        
    end
    redirect_to :back
end 
end