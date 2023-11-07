Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'api_secrets/create'
      scope '/users' do
        post '/create', to: 'users#create'
        put '/:id', to: 'users#update'
      end
      scope '/webhooks' do
        post '/create', to: 'web_hooks#create'
      end
      scope '/api_secrets' do
        get '/generate', to: 'api_secrets#generate'
        get '/existing_keys', to: 'api_secrets#existing_keys'
      end
    end
  end
end
