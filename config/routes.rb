Rails.application.routes.draw do
  root 'employees#index'
  resource :employees do
    collection { post :import }
  end
  get 'employees/index'
end
