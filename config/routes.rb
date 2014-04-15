Rails.application.routes.draw do
  devise_for :users

  root :to => 'dashboard#show'

  resource :dashboard, controller: "dashboard", only: [:show] do
    member do
      get :projects

      get :issues
    end
  end
end
