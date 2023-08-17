module ZohoTools
  class Oauth
    OAUTH_URL = '/oauth/v2/auth'.freeze
    TOKEN_URL = '/oauth/v2/token'.freeze

    def self.authorize(access_type: 'offline', scope: %w[ZohoCampaigns.campaign.ALL ZohoCampaigns.contact.ALL])
      uri = URI.join(ZohoTools.config.accounts_api_url, OAUTH_URL)
      uri.query = URI.encode_www_form(self.auth_params.merge({ redirect_uri: ZohoTools.config.callback_url,
                                                               access_type: access_type,
                                                               response_type: 'code',
                                                               scope: scope.join(',') }))
      uri.to_s
    end

    def self.authorization_code(code)
      response = RestClient.post(URI.join(ZohoTools.config.accounts_api_url, TOKEN_URL).to_s,
                                 self.auth_params.merge(code: code, grant_type: 'authorization_code', redirect_uri: ZohoTools.config.callback_url),
                                 { accept: :json })
      ZohoTools::Response.new(response)
    end

    def self.refresh_access_token(refresh_token)
      response = RestClient.post(URI.join(ZohoTools.config.accounts_api_url, TOKEN_URL).to_s,
                                 self.auth_params.merge(refresh_token: refresh_token, grant_type: 'refresh_token'),
                                 { accept: :json })
      ZohoTools::Response.new(response)
    end

    def self.auth_params
      { client_id: ZohoTools.config.client_id,
        client_secret: ZohoTools.config.client_secret }
    end
  end
end
