Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope '/users' do
        post '/create', to: 'users#create'
      end
      scope '/webhooks' do
        post '/create', to: 'web_hooks#create'
      end
    end
  end
end
