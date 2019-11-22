Rails.application.routes.draw do
    # resources :characters do
    #   resources :skills
    # end

  namespace :api do
    namespace :v1 do
      resources :characters do
        resources :skills
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end