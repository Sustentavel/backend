# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::TranslateTextController, :unit, type: :controller do
  render_views

  subject(:send_request) { post :create, params: params, format: :json }

  let(:params) do
    {
      translate: {
        text: 'Hello, World!',
        from_language: 'en',
        to_language: 'es'
      }
    }
  end

  it { expect(described_class).to be < ApplicationController }

  context 'when user is not authenticated' do
    it 'returns unauthorized' do
      send_request

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when user is authenticated' do
    let(:user) { create(:user) }

    before do
      authenticate_user(user)

      allow_any_instance_of(GoogleAiService).to receive(:generate_text).and_return("Mocked AI Response")
    end

    context 'when translation is successful' do
      it { is_expected.to have_http_status(:ok) }

      it 'returns translated text' do
        send_request

        expect(json_response['message']).to eq('Mocked AI Response')
      end
    end

    context 'when translation fails' do
      let(:params) do
        {
          translate: {
            text: 'Hello, World!',
            from_language: 'any_language',
            to_language: 'any_language'
          }
        }
      end

      it { is_expected.to have_http_status(:bad_request) }

      it 'returns error message' do
        send_request

        expect(json_response['message']).to eq('Linguagem de Origem não está incluído na lista e Linguagem de Destino não está incluído na lista')
      end
    end
  end
end
