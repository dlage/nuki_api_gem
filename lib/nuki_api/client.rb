# frozen_string_literal: true

require 'json'
require 'logger'
require_relative 'api'

module NukiApi
  # Main client class that implements communication with the API
  # global_params:
  # - include_related_objects: int	0-1	0
  # - page: int	positive	1
  # - per_page: int	positive	20
  class Client < API
    def account
      response = request(
        http_method: :get,
        endpoint: 'account'
      )
      process_response(response)
    end

    def smartlocks
      response = request(
        http_method: :get,
        endpoint: 'smartlock'
      )
      process_response(response)
    end

    def smartlocks_log
      response = request(
        http_method: :get,
        endpoint: 'smartlock/log'
      )
      process_response(response)
    end

    def smartlocks_auth
      response = request(
        http_method: :get,
        endpoint: 'smartlock/auth'
      )
      process_response(response)
    end

    def smartlock(smartlock_id, global_params = {})
      response = request(
        http_method: :get,
        endpoint: "smartlock/#{smartlock_id}",
        params: global_params
      )
      process_response(response)
    end

    def smartlock_log(smartlock_id, global_params = {})
      response = request(
        http_method: :get,
        endpoint: "smartlock/#{smartlock_id}/log",
        params: global_params
      )
      process_response(response)
    end

    def smartlock_auth(smartlock_id, global_params = {})
      response = request(
        http_method: :get,
        endpoint: "smartlock/#{smartlock_id}/auth",
        params: global_params
      )
      process_response(response)
    end

    # NukiApi::Client.new.search(query)
    def search(query, type = nil, global_params = {})
      response = request(
        http_method: :get,
        endpoint: 'search',
        params: { q: query, type: type }.merge!(global_params),
        cache_ttl: 3600 * 24
      )
      process_response(response)
    end

    protected

    def process_response(response)
      result = response
      case result
      when Hash
        result.transform_keys!(&:to_sym)
        result.each_value { |r| process_response(r) }
      when Array
        result.each { |r| process_response(r) }
      end
      result
    end
  end
end
