Rails.application.routes.draw do
  get 'search' => 'searchs#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: :new_admin_session
    post 'admins/sign_in' => 'admins/sessions#create', as: :admin_session
    delete 'logout' => 'admins/sessions#destroy', as: :destroy_admin_session
  end

  namespace :admin do
    resources :customers, only: %i[index show update destroy]
    resources :restaurants, only: %i[index show update destroy]
  end

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  root 'homes#top'
  get '/about', to: 'homes#about'

  scope module: 'public' do
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal', to: 'customers#withdrawal', as: 'withdrawal'
    # resources :maps, only: [:index] 未実装
    resources :customers, only: %i[index show edit update]
    resources :restaurants do
      get 'deletion_request', to: 'restaurants#deletion_request', as: 'deletion_request'
      patch 'deletion', to: 'restaurants#deletion', as: 'deletion'
      resources :reviews, only: %i[create destroy]
      resource :favorites, only: %i[create destroy]
      resource :wishes, only: %i[create destroy]
    end
    resources :histories, only: [:index, :create, :destroy]
  end
end
