# frozen_string_literal: true

class Api::V1::MainController < ApplicationController
  skip_before_action :authenticate_request

  def index; end
end
