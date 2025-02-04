# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NukiApi, 'listings' do
  describe 'smartlocks_auth' do
    let(:request_path) { '/smartlock/log' }
    let(:body) { fixture('smartlock_log.json') }
    let(:status) { 200 }

    before do
      stub_get(request_path).to_return(body: body, status: status)
    end

    let(:smartlocks_auth_response) { NukiApi::Client.new.smartlocks_auth }
    it 'returns correctly some data', :vcr do
      expect(smartlocks_auth_response).to be_kind_of(Array)
    end
    it 'each listing has basic information', :vcr do
      smartlocks_auth_response.each do |l|
        expect(l).to have_key(:id)
        expect(l).to have_key(:smartlock_id)
      end
    end
  end
end
