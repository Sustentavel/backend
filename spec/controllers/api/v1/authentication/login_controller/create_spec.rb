# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::Authentication::LoginController, :unit, type: :controller do
  render_views

  subject(:send_request) { post :create, params: params, format: :json }

  it { expect(described_class).to be < ApplicationController }

  describe 'POST #create' do
    context 'when the user exists' do
      let!(:user) { create(:user) }
      let(:params) { { user: { email: user.email, password: user.password } } }

      it 'returns a token' do
        send_request

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body, symbolize_names: true)).to include(:token)
      end
    end

    context 'when the user does not exist' do
      it 'returns an error' do
        post :create, params: { user: { email: 'nonexistent@example.com', password: 'nonexistent' } }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['message']).to eq(I18n.t('errors/messages.invalid_login'))
      end
    end
  end
end
