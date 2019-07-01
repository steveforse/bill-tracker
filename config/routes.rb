# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true, except: %i[show index]
  end

  root 'payees#index'
end
