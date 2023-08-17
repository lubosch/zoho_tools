# frozen_string_literal: true

module ZohoTools
  class Configuration
    attr_accessor :client_id, :client_secret, :campaigns_api_url, :accounts_api_url, :callback_url

    def initialize
      @client_secret = ENV['ZOHO_CLIENT_SECRET']
      @client_id = ENV['ZOHO_CLIENT_ID']
      @accounts_api_url = ENV['ZOHO_ACCOUNTS_API_URL']
      @campaigns_api_url = ENV['ZOHO_CAMPAIGNS_API_URL']
      @callback_url = ENV['ZOHO_CALLBACK_URL']
    end
  end
end
