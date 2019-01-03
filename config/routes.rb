Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  concern :commentable do
    resource :comments
  end

  resources :questions, concerns: :commentable, shallow: true do
    resources :answers
  end

  resources :answers, only: [], concerns: :commentable
  root to: "questions#index"

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

