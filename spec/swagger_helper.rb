# frozen_string_literal: true

require 'spec_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s
  config.swagger_dry_run = false

  config.openapi_specs = {
    'api/swagger.yaml': {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: ENV.fetch('DEVELOPMENT_URL'),
          variables: {
            defaultHost: {
              default: ENV.fetch('DEVELOPMENT_URL')
            }
          }
        }
      ]
    }
  }

  config.openapi_format = :yaml
end
