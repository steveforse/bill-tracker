Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true
  end

  root 'payees#index'
end
