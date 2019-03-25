Rails.application.routes.draw do

  root 'jobs#index'
  resource :jobs do
    collection { post :import }
  end
  get 'jobs/index'
  get 'jobs/import'
end
