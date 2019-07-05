# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true, except: %i[show index] do
      resources :payments, shallow: true
    end
  end

  root 'payees#index'
end
