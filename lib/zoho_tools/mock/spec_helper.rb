require 'webmock/rspec'

module ZohoTools
  module SpecHelper
    class Interface
      include RSpec::Mocks::ExampleMethods
      include WebMock::API

      def stub_authorize_code(code, access_token:, refresh_token:, success: true)
        response_body = if success
                          { access_token: access_token,
                            refresh_token: refresh_token,
                            scope: 'ZohoCampaigns.campaign.ALL ZohoCampaigns.contact.ALL',
                            api_domain: 'https://www.zohoapis.eu',
                            token_type: 'Bearer',
                            expires_in: 3600 }
                        else
                          { error: 'Invalid code' }
                        end
        stub_request(:post, URI.join(ZohoTools.config.accounts_api_url, '/oauth/v2/token'))
          .with(body: hash_including(client_id: ZohoTools.config.client_id,
                                     client_secret: ZohoTools.config.client_secret,
                                     code: code,
                                     grant_type: 'authorization_code',
                                     redirect_uri: ZohoTools.config.callback_url))
          .to_return(status: 200, body: response_body.to_json)
      end

      def stub_refresh_access_tokens(refresh_token, access_token:, success: true)
        response_body = if success
                          { access_token: access_token,
                            scope: 'ZohoCampaigns.campaign.ALL ZohoCampaigns.contact.ALL',
                            api_domain: 'https://www.zohoapis.eu',
                            token_type: 'Bearer',
                            expires_in: 3600 }
                        else
                          { error: 'Invalid refresh token' }
                        end
        stub_request(:post, URI.join(ZohoTools.config.accounts_api_url, '/oauth/v2/token'))
          .with(body: hash_including(client_id: ZohoTools.config.client_id,
                                     client_secret: ZohoTools.config.client_secret,
                                     refresh_token: refresh_token,
                                     grant_type: 'refresh_token'))
          .to_return(status: 200, body: response_body.to_json)
      end

      def stub_list_subscribe(access_token:, list_key:, contact_info:, source:, success: true)
        response_body = if success
                          { status: 'success',
                            message: 'A confirmation email is sent to the user. User needs to confirm to successfully subscribe.' }
                        else
                          { error: 'Invalid code' }
                        end

        stub_request(:post, URI.join(ZohoTools.config.campaigns_api_url, '/api/v1.1/json/listsubscribe'))
          .with(body: hash_including(listkey: list_key,
                                     resfmt: 'JSON',
                                     contactinfo: contact_info.is_a?(RSpec::Mocks::ArgumentMatchers::SingletonMatcher) ? contact_info : contact_info.to_json,
                                     source: source),
                headers: { 'Authorization' => "Zoho-oauthtoken #{access_token}" })
          .to_return(status: 200, body: response_body.to_json)
      end

      def stub_list_unsubscribe(access_token:, list_key:, contact_info:, success: true)
        response_body = if success
                          { status: 'success', message: 'User successfully unsubscribed.' }
                        else
                          { error: 'Invalid code' }
                        end

        stub_request(:post, URI.join(ZohoTools.config.campaigns_api_url, '/api/v1.1/json/listunsubscribe'))
          .with(body: hash_including(listkey: list_key,
                                     resfmt: 'JSON',
                                     contactinfo: contact_info.to_json),
                headers: { 'Authorization' => "Zoho-oauthtoken #{access_token}" })
          .to_return(status: 200, body: response_body.to_json)
      end
    end

    def zoho_tools
      @zoho_tools ||= Interface.new
    end
  end
end
