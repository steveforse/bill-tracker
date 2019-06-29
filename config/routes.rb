Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true, except: [:show, :index]
  end

  root 'payees#index'
end
