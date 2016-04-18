Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show, :index, :new] do
    resources :guides do
    get :autocomplete_guide_title, :on => :collection
      resources :comments, :only => [:create, :delete, :destroy]
      member do
        post 'up_vote'
        post 'down_vote'
        post 'unvote'
      end
    end
  end

  authenticated :user do
    root to:  'users#dashboard', as: "authenticated_root"
  end

  root 'welcome#index'

end
