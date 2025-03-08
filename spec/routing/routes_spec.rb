# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'authentication' do
    describe '/api/v1/authentication/login' do
      it 'routes to api/v1/authentication/login#create' do
        expect(post: '/api/v1/authentication/login').to route_to('api/v1/authentication/login#create', format: :json)
      end
    end

    describe 'register' do
      it 'routes to api/v1/authentication/register#create' do
        expect(post: '/api/v1/authentication/register').to route_to('api/v1/authentication/register#create', format: :json)
      end
    end
  end
end
