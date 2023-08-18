require 'spec_helper'

RSpec.describe ZohoTools::ListManagement do
  describe '.subscribe' do
    subject do
      described_class.subscribe(access_token: access_token, list_key: list_key, contact_info: contact_info, topic_id: topic_id, source: source)
    end

    let(:access_token) { '1000.access' }
    let(:list_key) { 'klmrkl2m3lkm43lk34lk43m43l3k4mlk4m3lk4k43mlkmkl4' }
    let(:contact_info) { { 'First Name': 'John', 'Last Name': 'Wik', 'Contact Email': 'john@example.com' } }
    let(:topic_id) { '44333' }
    let(:source) { 'app' }
    let(:refresh_token) { '123123' }

    it 'subscribes user' do
      stub_request(:post, 'https://campaigns.zoho.eu/api/v1.1/json/listsubscribe')
        .with(body: hash_including(listkey: 'klmrkl2m3lkm43lk34lk43m43l3k4mlk4m3lk4k43mlkmkl4',
                                   resfmt: 'JSON',
                                   contactinfo: contact_info.to_json,
                                   source: 'app',
                                   topic_id: '44333'),
              headers: { 'Authorization' => 'Zoho-oauthtoken 1000.access' })
        .to_return(status: 200,
                   body: { status: 'success',
                           message: 'A confirmation email is sent to the user. User needs to confirm to successfully subscribe.' }.to_json)
      expect(subject.success?).to be_truthy
    end
  end
  describe '.unsubscribe' do
    subject do
      described_class.unsubscribe(access_token: access_token, list_key: list_key, contact_info: contact_info, topic_id: topic_id)
    end

    let(:access_token) { '1000.access' }
    let(:list_key) { 'klmrkl2m3lkm43lk34lk43m43l3k4mlk4m3lk4k43mlkmkl4' }
    let(:contact_info) { { 'First Name': 'John', 'Last Name': 'Wik', 'Contact Email': 'john@example.com' } }
    let(:topic_id) { '44333' }
    let(:source) { 'app' }
    let(:refresh_token) { '123123' }

    it 'unsubscribes user' do
      stub_request(:post, 'https://campaigns.zoho.eu/api/v1.1/json/listunsubscribe')
        .with(body: hash_including(listkey: 'klmrkl2m3lkm43lk34lk43m43l3k4mlk4m3lk4k43mlkmkl4',
                                   resfmt: 'JSON',
                                   contactinfo: contact_info.to_json,
                                   topic_id: '44333'),
              headers: { 'Authorization' => 'Zoho-oauthtoken 1000.access' })
        .to_return(status: 200, body: { status: 'success', message: 'User successfully unsubscribed.' }.to_json)
      expect(subject.success?).to be_truthy
    end
  end
end
