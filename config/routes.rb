Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "daily_reports#index"

  resources :daily_reports, only: [ :index, :show, :update ]

  namespace :daily_reports do
    resources :medications, only: [ :update ]
  end
end
