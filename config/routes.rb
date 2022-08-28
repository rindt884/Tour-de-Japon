Rails.application.routes.draw do
  
  root to: 'public/homes#top'

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  get '/customers/:id/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe' # 退会確認画面
  patch '/customers/:id/withdrawal' => 'public/customers#withdrawal', as: 'withdrawal'  # 論理削除用のルーティング
  
  namespace :public do
    get "home/about" => "homes#about" # アバウトページ
    get "home/index" => "homes#index" # 投稿一覧
    resources :customers,only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      member do
          get :favorites
      end
      collection do
        get 'search' # ユーザー検索
      end
      get 'followings' => 'relationships#followings', as: 'followings' #フォロー一覧
      get 'followers' => 'relationships#followers', as: 'followers'    # フォロワー一覧
    end
    resources :posts,only:[:new, :index, :show, :edit, :create, :destroy, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only:[:create, :destroy]
      collection do
        get 'search' # 投稿検索
      end
    end
  end
  
  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update, :destroy]
    resources :posts, only:[:index, :show, :edit, :update, :destroy]
  end

end
