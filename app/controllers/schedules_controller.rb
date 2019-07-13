# frozen_string_literal: true

# Conroller for creating/editing schedules
class SchedulesController < ApplicationController
  before_action :set_payee, only: %i[new create]
  before_action :set_schedule, only: %i[edit update destroy show]
  before_action only: %i[update create] do convert_to_sql_dates( [:start_date, :end_date]) end

  # GET /payees/1/schedules/new
  def new
    @schedule = Schedule.new
    @schedule.payee = @payee
  end

  # GET /schedules/1
  def show
    @schedule = @schedule.decorate
    @payments = @schedule.payments
                         .rezort(params[:sort], 'date ASC')
                         .page(params[:page])
                         .decorate
  end

  # GET /schedules/1/edit
  def edit
    @schedule.start_date = l @schedule.start_date if @schedule.start_date
    @schedule.end_date = l @schedule.end_date if @schedule.end_date
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.payee_id = @payee.id

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @payee, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    payee = @schedule.payee
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to payee, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_payee
    @payee = Payee.find(params[:payee_id])
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(
      :name,
      :start_date,
      :end_date,
      :frequency,
      :autopay,
      :minimum_payment
    )
  end
end
