# frozen_string_literal: true

# Handles creation of payments
class PaymentsController < ApplicationController
  before_action :set_schedule, only: %i[new create]
  before_action :set_payment, only: %i[show edit update destroy]
  before_action only: %i[update create] do
    convert_to_sql_dates(%i[date due_date])
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @payment.schedule = @schedule
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments
  # POST /payments.json
  # rubocop: disable Metrics/AbcSize
  def create
    @payment = Payment.new(payment_params).tap { |payment| payment.schedule_id = @schedule.id }

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment.schedule, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop: enable Metrics/AbcSize

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment.schedule, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    schedule = @payment.schedule
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to schedule, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(:schedule_id, :amount, :date, :comment, :due_date)
  end
end
