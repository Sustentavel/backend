# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/main', type: :request, swagger_doc: 'api/swagger.yaml' do
  let(:user) { create(:user) }

  path '/' do
    get 'Shows informations of API' do
      tags 'v1 API'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'Informations loaded successfully' do
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
