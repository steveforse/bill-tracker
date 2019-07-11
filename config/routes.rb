# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true, except: %i[show index]
  end

  get 'calendar', to: 'calendar#index'
  get 'calendar/events', to: 'calendar#events'

  root 'payees#index'
end
