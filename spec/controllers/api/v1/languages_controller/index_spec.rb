# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V1::LanguagesController, :unit, type: :controller do
  render_views

  subject(:send_request) { get :index, format: :json }

  it { expect(described_class).to be < ApplicationController }

  context 'when user is not authenticated' do
    it 'returns unauthorized' do
      send_request

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when user is authenticated' do
    let(:user) { create(:user) }

    before { authenticate_user(user) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns languages' do
      send_request

      expect(json_response[:languages]).to eq(Language.all.map { |language|
        { acronym: language.acronym, name: language.name }
      })
    end
  end
end
