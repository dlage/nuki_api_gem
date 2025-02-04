# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NukiApi do
  it 'has a version number' do
    expect(NukiApi::VERSION).not_to be nil
  end

  api_key = 'test_key'
  api_endpoint = 'https://api.nuki.io'
  api_options = { token: api_key, endpoint: api_endpoint }

  describe 'NukiApi::Client' do
    let(:api_client) { NukiApi.new(api_options) }
    it 'is initialized with options' do
      expect(api_client).to be_a(NukiApi::Client)
      expect(api_client.token).to equal(api_key)
      expect(api_client.endpoint).to equal(api_endpoint)
    end
    let(:default_api_client) { NukiApi.new }
    it 'defaults are initialized as well' do
      expect(api_client).to be_a(NukiApi::Client)
      expect(api_client.token).not_to be_nil
      expect(api_client.endpoint).not_to be_nil
    end
  end
end
