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

    # SmartlockAuthCreate{
    # name*	string
    # The name of the authorization (max 32 chars)
    #
    # allowedFromDate	string($date-time)
    # The allowed from date
    #
    # allowedUntilDate	string($date-time)
    # The allowed until date
    #
    # allowedWeekDays	integer($int32)
    # minimum: 0
    # maximum: 127
    # The allowed weekdays bitmask: 64 .. monday, 32 .. tuesday, 16 .. wednesday, 8 .. thursday, 4 .. friday, 2 .. saturday, 1 .. sunday
    #
    # allowedFromTime	integer($int32)
    # The allowed from time (in minutes from midnight)
    #
    # allowedUntilTime	integer($int32)
    # The allowed until time (in minutes from midnight)
    #
    # accountUserId	integer($int32)
    # The id of the linked account user (required if type is NOT 13 .. keypad)
    #
    # remoteAllowed*	boolean
    # True if the auth has remote access
    #
    # smartActionsEnabled	boolean
    # The smart actions enabled flag
    #
    # type	integer($int32)
    # The optional type of the auth 0 .. app (default), 2 .. fob, 13 .. keypad
    #
    # code	integer($int32)
    # The code of the keypad authorization (only for keypad)
    #
    # }
    def smartlock_auth_create(params = {})
      response = request(
        http_method: :put,
        endpoint: 'smartlock/auth',
        params: params,
        cache_ttl: 5 # Prevent "double click" for 5 seconds
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
