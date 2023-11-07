Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope '/users' do
        post '/create', to: 'users#create'
      end
    end
  end
end
