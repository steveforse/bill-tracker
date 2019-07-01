# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe PayeesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Payee. As you add validations to Payee, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:payee)
  end

  let(:invalid_attributes) do
    attributes = attributes_for(:payee)
    attributes[:name] = nil
    attributes
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PayeesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Payee.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      payee = Payee.create! valid_attributes
      get :show, params: { id: payee.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      payee = Payee.create! valid_attributes
      get :edit, params: { id: payee.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Payee' do
        expect do
          post :create, params: { payee: valid_attributes }, session: valid_session
        end.to change(Payee, :count).by(1)
      end

      it 'redirects to the created payee' do
        post :create, params: { payee: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Payee.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { payee: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:payee)
      end

      it 'updates the requested payee' do
        payee = Payee.create! valid_attributes
        put :update, params: { id: payee.to_param, payee: new_attributes }, session: valid_session
        payee.reload
        expect(payee).to be_valid
      end

      it 'redirects to the payee' do
        payee = Payee.create! valid_attributes
        put :update, params: { id: payee.to_param, payee: valid_attributes }, session: valid_session
        expect(response).to redirect_to(payee)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        payee = Payee.create! valid_attributes
        put :update, params: { id: payee.to_param, payee: invalid_attributes },
                     session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested payee' do
      payee = Payee.create! valid_attributes
      expect do
        delete :destroy, params: { id: payee.to_param }, session: valid_session
      end.to change(Payee, :count).by(-1)
    end

    it 'redirects to the payees list' do
      payee = Payee.create! valid_attributes
      delete :destroy, params: { id: payee.to_param }, session: valid_session
      expect(response).to redirect_to(payees_url)
    end
  end
end
# rubocop: enable Metrics/BlockLength
