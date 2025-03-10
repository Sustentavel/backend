# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/languages', type: :request, swagger_doc: 'api/swagger.yaml' do
  let(:user) { create(:user) }

  path '/api/v1/languages' do
    get 'Loads all languages' do
      tags 'Languages'
      security [Bearer: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string

      let(:access_token) { JwtService.encode(user_id: user.id) }
      let(:Authorization) { "Bearer #{access_token}" }

      response '200', 'Languages loaded' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json': {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response '401', 'Expired or invalid session' do
        let(:translate_params) { {} }
        let(:Authorization) { nil }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json': {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
