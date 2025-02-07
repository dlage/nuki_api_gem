# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NukiApi, 'smartlocks' do
  describe 'smartlocks_log' do
    let(:request_path) { '/smartlock/log' }
    let(:body) { fixture('smartlocks_log.json') }
    let(:body) { fixture('smartlocks_log.json') }
    let(:status) { 200 }

    before do
      stub_get(request_path).to_return(body: body, status: status)
    end

    let(:smartlocks_log_response) { NukiApi::Client.new.smartlocks_log }
    it 'returns correctly some data', :vcr do
      expect(smartlocks_log_response).to be_kind_of(Array)
    end
    it 'each smartlock has basic information', :vcr do
      smartlocks_log_response.each do |l|
        expect(l).to have_key(:id)
        expect(l).to have_key(:smartlockId)
        expect(l).to have_key(:deviceType)
      end
    end
  end
end
