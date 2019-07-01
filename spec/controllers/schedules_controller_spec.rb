# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
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

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SchedulesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { payee_id: payee.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      schedule = Schedule.create! valid_attributes
      get :edit, params: { payee_id: payee.id, id: schedule.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Schedule' do
        expect do
          post :create, params: { payee_id: payee.id, schedule: valid_attributes },
                        session: valid_session
        end.to change(Schedule, :count).by(1)
      end

      it 'redirects to the created schedule' do
        post :create, params: { payee_id: payee.id, schedule: valid_attributes },
                      session: valid_session
        expect(response).to redirect_to(payee)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { payee_id: payee.id, schedule: invalid_attributes },
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

      it 'updates the requested schedule' do
        schedule = Schedule.create! valid_attributes
        put :update, params: { id: schedule.to_param, schedule: new_attributes },
                     session: valid_session
        schedule.reload
        expect(schedule).to be_valid
      end

      it 'redirects to the schedule' do
        schedule = Schedule.create! valid_attributes
        put :update, params: { id: schedule.to_param, schedule: valid_attributes },
                     session: valid_session
        expect(response).to redirect_to(payee)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        schedule = Schedule.create! valid_attributes
        put :update, params: { id: schedule.to_param, schedule: invalid_attributes },
                     session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested schedule' do
      schedule = Schedule.create! valid_attributes
      expect do
        delete :destroy, params: { id: schedule.to_param }, session: valid_session
      end.to change(Schedule, :count).by(-1)
    end

    it 'redirects to the schedules list' do
      schedule = Schedule.create! valid_attributes
      delete :destroy, params: { id: schedule.to_param }, session: valid_session
      expect(response).to redirect_to(payee)
    end
  end
end
# rubocop: enable Metrics/BlockLength
