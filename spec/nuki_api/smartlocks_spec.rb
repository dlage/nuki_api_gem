# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NukiApi, 'smartlocks' do
  let(:request_path) { '/smartlock' }
  let(:body) { fixture('smartlocks.json') }
  let(:status) { 200 }

  before do
    stub_get(request_path).to_return(body: body, status: status)
  end

  let(:smartlocks_result) { NukiApi::Client.new.smartlocks }
  it 'returns smartlocks', :vcr do
    expect(smartlocks_result).to be_an_instance_of(Array)
    smartlocks_result.each do |i|
      expect(i).to have_key(:smartlock_id)
      expect(i).to have_key(:account_id)
      expect(i).to have_key(:type)
      expect(i).to have_key(:name)
      expect(i).to have_key(:config)
    end
  end
end
