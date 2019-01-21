Rails.application.routes.draw do

  devise_for :users
  
  root 'home#index'
  
  get 'home/main'
  
  get 'mypage/mypage'
  
  #home
  get 'home/index'

  get 'home/new'

  get 'home/create'

  get 'home/edit'
  
  get 'home/bot' => 'home#bot'
  
  
  #board
  get 'board/index'
  
  get 'board/detail/:post_id' => 'board#detail'
  
  get 'board/food' => 'board#food'

  get 'board/fashion'
  
  get 'board/love'

  get 'board/new'

  post 'board/create'
  
  #스크랩
  post '/board/:post_id/scrap' => 'scrap#scrap_toggle'

  get '/board/delete/:post_id' => 'board#delete'
  
  get '/board/edit/:post_id' => 'board#edit'
  
  post '/board/update/:post_id' => 'board#update'
  
  get '/:post_id/comment_create' => 'board#comment_create'
  
  get '/:post_id/comment_edit/:comment_id' => 'board#comment_edit'
  
  post '/:post_id/comment_update/:comment_id' => 'board#comment_update'
  
  get '/:post_id/comment_destroy/:comment_id' => 'board#comment_destroy'
  
  get  '/:post_id/:comment_id/recomment_create' => 'board#recomment_create'
  
  get '/:post_id/recomment_edit/:comment_id/:recomment_id' => 'board#recomment_edit'
  
  post '/:post_id/recomment_update/:comment_id/:recomment_id' => 'board#recomment_update'
  
  get '/:post_id/recomment_destroy/:comment_id/:recomment_id' => 'board#recomment_destroy'
  
  resources :posts do
    member do

      get "like", to: "board#upvote"
  
      get "dislike", to: "board#downvote"
  
    end
  end
  
  
  
end
