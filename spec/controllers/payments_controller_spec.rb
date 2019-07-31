# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  before do
    sign_in create(:user)
  end

  let(:schedule) { create(:schedule) }
  let(:payment) { create(:payment, schedule: schedule) }

  let(:valid_attributes) do
    attributes = attributes_for(:payment, schedule: schedule)
    attributes[:schedule_id] = schedule.id
    attributes
  end

  let(:invalid_attributes) do
    attributes = attributes_for(:payment, schedule: schedule)
    attributes[:amount] = nil
    attributes
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PaymentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { schedule_id: payment.schedule.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      payment = Payment.create! valid_attributes
      get :edit, params: { id: payment.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Payment' do
        expect do
          post :create, params: { schedule_id: schedule.to_param,
                                  payment: valid_attributes }, session: valid_session
        end.to change(Payment, :count).by(1)
      end

      it 'redirects to the created payment' do
        post :create, params: { schedule_id: schedule.to_param,
                                payment: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Payment.last.schedule)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        expect do
          post :create, params: { schedule_id: schedule.to_param,
                                  payment: invalid_attributes }, session: valid_session
        end.not_to change(Payment, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        attributes = attributes_for(:payment, schedule: schedule)
        attributes[:amount] = 200
        attributes
      end

      it 'updates the requested payment' do
        payment = Payment.create! valid_attributes
        put :update, params: { id: payment.to_param, payment: new_attributes },
                     session: valid_session
        payment.reload
        expect(payment.amount).to eq(200)
      end

      it 'redirects to the payment' do
        payment = Payment.create! valid_attributes
        put :update, params: { id: payment.to_param, payment: valid_attributes },
                     session: valid_session
        expect(response).to redirect_to(payment.schedule)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        payment = Payment.create! valid_attributes
        put :update, params: { id: payment.to_param, payment: invalid_attributes },
                     session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested payment' do
      payment = Payment.create! valid_attributes
      expect do
        delete :destroy, params: { id: payment.to_param }, session: valid_session
      end.to change(Payment, :count).by(-1)
    end

    it 'redirects to the payments list' do
      payment = Payment.create! valid_attributes
      delete :destroy, params: { id: payment.to_param }, session: valid_session
      expect(response).to redirect_to(schedule_url(payment.schedule))
    end
  end
end
