Rails.application.routes.draw do
  devise_for :users, :skip => :registrations

  root :to => 'dashboard#show'

  resources :users, :only => [:show, :edit, :update]

  resources :requests, :only => [:new, :show, :edit, :update, :destroy, :create] do
    get :sync
  end

  resource :dashboard, :controller => 'dashboard', :only => :show do
    member do
      get :projects

      get :ajax_projects

      get :issues

      get :ajax_issues

      get :requests

      get :ajax_activities
    end
  end

  namespace :admin do
    root :to => 'dashboard#show'

    resources :users

    resources :requests

    resources :projects

    resources :story_points, :only => :index do
      get :sync, :users, :on => :collection
    end

    resources :changelogs, :only => :index do
      get :sync, :on => :collection
    end

    resources :changelogs, :only => :index
  end
end
