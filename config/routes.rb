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

  namespace :public do
    resource :customers,only:[:show, :edit]
    resources :posts,only:[:new, :index, :show, :edit, :create, :destroy, :update]
  end

end
