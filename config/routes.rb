require 'sidekiq/web'

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  root to: 'home#index'

  # Master
  namespace :master, path: 'm' do
    # Dashboard
    get 'dashboard', to: 'dashboard#index'
  end

  # Master
  namespace :client, path: 'c' do
    # Dashboard
    get 'dashboard',       to: 'dashboard#index'
  end  
end
