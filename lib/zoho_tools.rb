require 'rest-client'

require 'zoho_tools/configuration'
require 'zoho_tools/list_management'
require 'zoho_tools/response'
require 'zoho_tools/version'
require 'zoho_tools/oauth'

module ZohoTools
  @configuration = Configuration.new

  def self.config
    @configuration
  end

  def self.configure
    yield(@configuration)
  end

  class Error < StandardError
  end
end
