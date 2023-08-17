module ZohoTools
  class ListManagement
    SUBSCRIBE_URL = '/api/v1.1/json/listsubscribe'.freeze
    UNSUBSCRIBE_URL = '/api/v1.1/json/listunsubscribe'.freeze

    def self.subscribe(access_token:, list_key:, contact_info:, topic_id: nil, source: nil)
      params = { listkey: list_key, resfmt: 'JSON', contactinfo: contact_info.to_json }
      params = params.merge(source: source) if source
      params = params.merge(topic_id: topic_id) if topic_id

      response = RestClient.post(URI.join(ZohoTools.config.campaigns_api_url, SUBSCRIBE_URL).to_s,
                                 params,
                                 { 'Authorization': "Zoho-oauthtoken #{access_token}" })
      ZohoTools::Response.new(response)

    end

    def self.unsubscribe(access_token:, list_key:, contact_info:, topic_id: nil)
      params = { listkey: list_key, resfmt: 'JSON', contactinfo: contact_info.to_json }
      params = params.merge(topic_id: topic_id) if topic_id

      response = RestClient.post(URI.join(ZohoTools.config.campaigns_api_url, UNSUBSCRIBE_URL).to_s,
                                 params,
                                 { 'Authorization': "Zoho-oauthtoken #{access_token}" })
      ZohoTools::Response.new(response)
    end
  end
end
