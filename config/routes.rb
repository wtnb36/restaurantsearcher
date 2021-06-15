Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

  #デプロイ時はこっちのルーテイングへ
  #devise_for :admins, skip: :all
  #devise_scope :admin do
  #get 'admins/sign_in' => 'admins/sessions#new', as: :new_admin_session
  #post 'admins/sign_in' => 'admins/sessions#create', as: :admin_session
  #delete 'logout' => 'admins/sessions#destroy', as: :destroy_admin_session
  #end

  namespace :admin do
    resources :customers, only: [:index, :show, :destroy, :update]
    resources :restaurants
  end


  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  root 'homes#top'
  get '/about', to: 'homes#about'

  scope module: 'public' do
    get 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal', to: 'customers#withdrawal', as: 'withdrawal'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :restaurants do
      resources :reviews, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :histories
  end

end
