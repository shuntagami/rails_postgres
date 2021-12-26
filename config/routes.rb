Rails.application.routes.draw do
  # root to: 'general#index'
  namespace :api do
    get '_healthcheck' => 'healthcheck#healthcheck'
  end
end
