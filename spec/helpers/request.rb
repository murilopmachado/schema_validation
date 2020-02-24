require 'pry'
require 'json'
require 'rest-client'
require 'uri'

# Constructor that could be easily reused for any requests over OSRM

class Requestor
  attr_accessor :host, :path, :headers, :method, :payload, :query_params

  def initialize
    @host         = host
    @path         = path
    @query_params = query_params
    @headers = headers
    @method  = method
    @payload = payload
  end

  def execute
    if host.nil? || host == ''
      raise(RequestorMandatoryParamsException, "Invalid host parameter #{host}")
    end

    url = host + path + query_params

    RestClient::Request.execute(
      method: method.downcase.to_sym,
      url: url,
      payload: payload,
      timeout: 50,
      headers: headers
    ) do |res, req, results|
      @response = {
        'request'  => req,
        'response' => res,
        'results'  => results
      }
    end
    @response
  end
end

RequestorMandatoryParamsException = Class.new(StandardError)
