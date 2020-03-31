require 'sidekiq/web'

Rails.application.routes.draw do
  
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  devise_for :users, path: "users", controllers: { sessions: "users/sessions"}
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions"}

  devise_scope :user do
    get "dashboard-client" => "home#client_index", :as => :authenticated_user_root
  end

  devise_scope :admin do
    get "dashboard" => "home#master_index", :as => :admin_dashboard
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
