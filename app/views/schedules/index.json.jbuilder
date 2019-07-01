# frozen_string_literal: true

json.array! @schedules, partial: 'schedules/schedule', as: :schedule
