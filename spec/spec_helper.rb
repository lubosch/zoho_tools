require "bundler/setup"
require "zoho_tools"
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ZohoTools.configure do |config|
  config.client_id = '1000.id123'
  config.client_secret = 'secret123'
  config.accounts_api_url = 'https://accounts.zoho.eu'
  config.campaigns_api_url = 'https://campaigns.zoho.eu'
  config.callback_url = 'http://localhost:3000/webhooks/zohos'
end
