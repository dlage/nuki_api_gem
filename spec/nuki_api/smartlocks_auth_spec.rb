# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NukiApi, 'smartlocks_auth' do
  describe 'smartlocks_auth' do
    let(:request_path) { '/smartlock/auth' }
    let(:body) { fixture('smartlocks_auth.json') }
    let(:status) { 200 }

    before do
      stub_get(request_path).to_return(body: body, status: status)
    end

    let(:smartlocks_auth_response) { NukiApi::Client.new.smartlocks_auth }
    it 'returns correctly some data', :vcr do
      expect(smartlocks_auth_response).to be_kind_of(Array)
    end
    it 'each smartlock has basic information', :vcr do
      smartlocks_auth_response.each do |l|
        expect(l).to have_key(:id)
        expect(l).to have_key(:smartlockId)
      end
    end
  end
end
RSpec.describe NukiApi, 'smartlocks_auth_create' do
  describe 'smartlocks_auth_create' do
    let(:request_path) { '/smartlock/auth' }
    let(:params) { fixture('smartlocks_auth_create_request.json') }
    let(:response) { fixture('smartlocks_auth_create_response.json') }
    let(:status) { 204 }

    before do
      stub_put(request_path).to_return(body: response, status: status)
    end

    let(:smartlocks_auth_create) { NukiApi::Client.new.smartlocks_auth_create(params: params) }
    it 'returns correctly empty data', :vcr do
      expect(smartlocks_auth_create).to be_nil
    end
  end
end
RSpec.describe NukiApi, 'smartlocks_auth_create' do
  describe 'smartlock_auth_create' do
    let(:smartlock_id) { '12345' }
    let(:request_path) { "/smartlock/#{smartlock_id}/auth" }
    let(:params) { fixture('smartlock_auth_create_request.json') }
    let(:status) { 204 }

    before do
      stub_put(request_path).to_return(status: status)
    end

    let(:smartlock_auth_create_response) { NukiApi::Client.new.smartlock_auth_create(smartlock_id, params: params) }
    it 'returns correctly empty data', :vcr do
      expect(smartlock_auth_create_response).to be_nil
    end
  end
end
