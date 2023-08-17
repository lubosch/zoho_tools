module ZohoTools
  module SpecHelper
    class Interface
      def stub_refresh_access_tokens(refresh_token, access_token:)
        stub_request(:post, URI.join(ZohoTools.config.accounts_api_url, '/oauth/v2/token'))
          .with(body: hash_including(client_id: ZohoTools.config.client_id,
                                     client_secret: ZohoTools.config.client_secret,
                                     refresh_token: refresh_token,
                                     grant_type: 'refresh_token'))
          .to_return(status: 200,
                     body: { access_token: access_token,
                             scope: 'ZohoCampaigns.campaign.ALL ZohoCampaigns.contact.ALL',
                             api_domain: 'https://www.zohoapis.eu',
                             token_type: 'Bearer',
                             expires_in: 3600 }.to_json)
      end
    end

    def zoho_tools
      @zoho_tools ||= Interface.new
    end
  end
end
