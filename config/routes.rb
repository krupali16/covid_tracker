Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    post :register_user, on: :collection
    post :perform_self_assessment, on: :collection
  end

  resources :covid_details do
    post :update_covid_result, on: :collection
  end
end
