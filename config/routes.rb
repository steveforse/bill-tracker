# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true, except: :index do
      resources :payments, shallow: true, except: %i[index show]
    end
  end

  get 'calendar', to: 'calendar#index'
  get 'calendar/events', to: 'calendar#events'

  root 'calendar#index'
end
