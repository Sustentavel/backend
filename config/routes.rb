Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  defaults format: :json do
    namespace :api do
      resources :test, only: :index
    end

    get "/" => "api/main#index", as: :main, only: :index
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
