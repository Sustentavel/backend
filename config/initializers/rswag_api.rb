Rswag::Api.configure do |c|
  c.openapi_root = Rails.root.to_s + '/swagger'
  c.swagger_headers = { 'Content-Type' => 'application/json; charset=UTF-8' }
end
