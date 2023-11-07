Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'api_secrets/create'
      scope '/users' do
        post '/create', to: 'users#create'
      end
      scope '/webhooks' do
        post '/create', to: 'web_hooks#create'
      end
      resources :api_secrets, only: [:create]
    end
  end
end
