# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payees do
    resources :schedules, shallow: true, except: %i[index] do
      resources :payments, shallow: true, except: :index
    end
  end

  get 'calendar', to: 'calendar#index'
  get 'calendar/events', to: 'calendar#events'

  root 'calendar#index'
end
