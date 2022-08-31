Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  concern :apis_base do
    resources :applications, param: :token, :except => [:destroy] do
      resources :chats, param: :number, :except => [:destroy] do
        resources :messages, param: :number, :except => [:destroy], controller: 'chat_messages'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :apis_base
    end
  end
end
