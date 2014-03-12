require "mercury_ruby_client/version"
require 'net/https'
require 'uri'
require 'base64'
require 'json'

module MercuryRubyClient
  # Your code goes here...
  class Transaction
    def initialize()
      url                  = "https://w1.mercurycert.net/PaymentsAPI"
      @username            = "595901"
      @password            = "xyz"
      user_and_pass        = @username + ':' + @password
      @base64user_and_pass = Base64.encode64(user_and_pass)
      @uri                 = URI.parse(url)
      @http                = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl        = true if (@uri.scheme == 'https')
      #@test                = merchant_params[:test]
    end

    def process(transaction_params, resource)
      data = transaction_params.to_json.to_s
      @headers             = {
          'Content-Type'   => 'application/json',
          'Content-Length' => data.length.to_s,
          'Authorization'  => "Basic #{@base64user_and_pass}",
      }

      response      = @http.post(@uri.path + resource, data, @headers)
      response_hash = JSON.parse(response.body)
    end
  end
end
