require 'spec_helper'

RSpec.describe ZohoTools::Oauth do
  describe '.authorize' do
    subject { described_class.authorize }
    it 'generates url to authorize server' do
      expect(subject).to include('https://accounts.zoho.eu/oauth/v2/auth',
                                 'client_id=1000.id123',
                                 'client_secret=secret123',
                                 'redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fwebhooks%2Fzohos',
                                 'access_type=offline',
                                 'response_type=code',
                                 'scope=ZohoCampaigns.campaign.ALL%2CZohoCampaigns.contact.ALL')
    end
  end

  describe '.authorization_code' do
    subject { described_class.authorization_code(code) }
    let(:code) { '123123' }
    it 'returns authorization codes' do
      stub_request(:post, 'https://accounts.zoho.eu/oauth/v2/token')
        .with(body: hash_including(client_id: '1000.id123',
                                   client_secret: 'secret123',
                                   code: '123123',
                                   grant_type: 'authorization_code',
                                   redirect_uri: 'http://localhost:3000/webhooks/zohos'))
        .to_return(status: 200,
                   body: { access_token: '1000.e4d172a421c1522aaf0d565b53dd.84913cdec11207537b1a649636b3',
                           refresh_token: '1000.e4d172a421c1522aaf0d565b53dd.84913cdec11207537b1a649636b36',
                           scope: 'ZohoCampaigns.campaign.ALL ZohoCampaigns.contact.ALL',
                           api_domain: 'https://www.zohoapis.eu',
                           token_type: 'Bearer',
                           expires_in: 3600 }.to_json)
      expect(subject.success?).to be_truthy
    end
  end

  describe '.refresh_access_token' do
    subject { described_class.refresh_access_token(refresh_token) }
    let(:refresh_token) { '123123' }
    it 'returns refreshed authorization codes' do
      stub_request(:post, 'https://accounts.zoho.eu/oauth/v2/token')
        .with(body: hash_including(client_id: '1000.id123',
                                   client_secret: 'secret123',
                                   refresh_token: '123123',
                                   grant_type: 'refresh_token'))
        .to_return(status: 200,
                   body: { access_token: '1000.e4d172a421c1522aaf0d565b53dd2c8d.84913cdec11207537b1a649636b3686b',
                           scope: 'ZohoCampaigns.campaign.ALL ZohoCampaigns.contact.ALL',
                           api_domain: 'https://www.zohoapis.eu',
                           token_type: 'Bearer',
                           expires_in: 3600 }.to_json)
      expect(subject.success?).to be_truthy
    end
  end
end
