Rails.application.routes.draw do
  devise_for :users
  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy]

  root 'topics#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
