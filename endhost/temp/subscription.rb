#!/usr/bin/env ruby
#---------------------------------------------------------------------
# Licensed Materials - Property of IBM
# 5725-M99
#
# (C) Copyright IBM Corporation 2013. All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication
# or disclosure restricted by GSA ADP Schedule Contract
# with IBM Corp.
#---------------------------------------------------------------------

require 'net/http'
require 'securerandom'
require 'json'

def request_payload
  {
    'callbackURL' => 'https://localhost:5000/api/v1/callback',
    'requestorEmail' => "#{ENV['LOGNAME'] || 'user'}@us.ibm.com",
    'subscriptionID' => SecureRandom.hex,
    'subscriptionType' => 'trial'
  }
end


##
# Sends an HTTP POST to the instance's callback URL with the appropriate completion payload.
def post_request
  # uri = URI('https://10.80.64.194:3000/api/v1/subscription')
  uri = URI('http://localhost:3000/api/v1/subscription')
  
  http_client = Net::HTTP.new(uri.host, uri.port)
  http_client.use_ssl = uri.scheme.downcase == 'https' 
  http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
  http_client.ssl_version = :TLSv1

  request = Net::HTTP::Post.new(uri)
  request.basic_auth("prachi", "password")  
  request['Content-Type'] = 'application/json; charset=utf-8'
  request.body = request_payload.to_json
  puts "INFO: subscriptionID #{request_payload['subscriptionID']}"
  
  begin
    response = http_client.start { |client| client.request(request) }
    
    if (200...300).include?(response.code.to_i) && response.body
    begin
      puts JSON.pretty_generate(JSON.parse(response.body))    
    rescue Exception => e
      puts response.body
    end
    end
  end
end
##

post_request
