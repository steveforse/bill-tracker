# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe PayeesController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:payee)
  end

  let(:invalid_attributes) do
    attributes = attributes_for(:payee)
    attributes[:name] = nil
    attributes
  end

  let(:payee) do
    create(:payee)
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
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
        put :update, params: { id: payee.to_param, payee: new_attributes }, session: valid_session
        payee.reload
        expect(payee.attributes.except('id', 'created_at', 'updated_at')).to eq(
          new_attributes.stringify_keys
        )
      end

      it 'redirects to the payee' do
        put :update, params: { id: payee.to_param, payee: valid_attributes }, session: valid_session
        expect(response).to redirect_to(payee)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: payee.to_param, payee: invalid_attributes },
                     session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested payee' do
      payee
      expect do
        delete :destroy, params: { id: payee.to_param }, session: valid_session
      end.to change(Payee, :count).by(-1)
    end

    it 'redirects to the payees list' do
      delete :destroy, params: { id: payee.to_param }, session: valid_session
      expect(response).to redirect_to(payees_url)
    end
  end
end
# rubocop: enable Metrics/BlockLength
