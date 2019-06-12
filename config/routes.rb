Rails.application.routes.draw do
  resources :payees

  root 'payees#index'
end
