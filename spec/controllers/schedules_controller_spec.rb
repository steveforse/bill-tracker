# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Schedule. As you add validations to Schedule, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes = attributes_for(:schedule)
    attributes[:payee_id] = payee.id
    attributes
  end

  let(:invalid_attributes) do
    attributes = attributes_for(:schedule)
    attributes[:frequency] = nil
    attributes
  end

  let(:payee) do
    create(:payee)
  end

  let(:schedule) do
    create(:schedule)
  end

  let(:valid_session) { {} }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { payee_id: schedule.payee.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { payee_id: schedule.payee.to_param, id: schedule.to_param },
                 session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Schedule' do
        expect do
          post :create, params: { payee_id: payee.to_param, schedule: valid_attributes },
                        session: valid_session
        end.to change(Schedule, :count).by(1)
      end

      it 'redirects to the created schedule' do
        post :create, params: { payee_id: schedule.payee.to_param, schedule: valid_attributes },
                      session: valid_session
        expect(response).to redirect_to(schedule.payee)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { payee_id: schedule.payee.id, schedule: invalid_attributes },
                      session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:schedule)
      end

      let(:min_pay) { 'minimum_payment' }

      it 'updates the requested schedule' do
        put :update, params: { id: schedule.id, schedule: new_attributes }, session: valid_session
        expect(schedule.reload.attributes.except(
                 'id', 'payee_id', 'created_at', 'updated_at'
               )).to eq(new_attributes.stringify_keys.tap { |a| a[min_pay] = a[min_pay].to_f })
      end

      it 'redirects to the schedule' do
        put :update, params: { id: schedule.to_param, schedule: valid_attributes },
                     session: valid_session
        expect(response).to redirect_to(schedule.payee)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: schedule.to_param, schedule: invalid_attributes },
                     session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested schedule' do
      schedule
      expect do
        delete :destroy, params: { id: schedule.to_param }, session: valid_session
      end.to change(Schedule, :count).by(-1)
    end

    it 'redirects to the schedules list' do
      delete :destroy, params: { id: schedule.to_param }, session: valid_session
      expect(response).to redirect_to(schedule.payee)
    end
  end
end
