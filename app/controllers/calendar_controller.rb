class CalendarController < ApplicationController
  # GET /calendar
  # GET /calendar.json
  def index
  end

  def events
    @start_date = params[:start] || nil
    @end_date = params[:end] || nil

    @schedules = Schedule.includes(:payee).all
  end
end
