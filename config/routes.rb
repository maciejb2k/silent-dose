Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :daily_reports_medications do
    post :move_up, on: :member
    post :move_down, on: :member
  end
end
