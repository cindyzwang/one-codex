Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    resources :taxonomy, only: [:show] do
      resources :children, only: [:index]
      resources :parents, only: [:index]
    end

    resources :taxonomy_search, only: [:create]
  end
end
