class CalendarController < ApplicationController
  # GET /calendar
  # GET /calendar.json
  def index
  end

  def events
    start_date = params[:start] || nil
    end_date = params[:end] || nil

    @payments = Payment.includes(:schedule).where(date: start_date..end_date)
    @schedules = Schedule.includes(:payee).all
  end
end
