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

SAAS_ENDPOINT_SCHEME = ENV['SAAS_ENDPOINT_SCHEME'] || 'https'
SAAS_ENDPOINT_USER = ENV['SAAS_ENDPOINT_USER'] || 'prachi'
SAAS_ENDPOINT_PASSWORD = ENV['SAAS_ENDPOINT_PASSWORD'] || 'password'

SUBSCRIPTION_CALLBACK = ENV['SUBSCRIPTION_CALLBACK'] || 'https://localhost:5000/api/v1/callback'
SUBSCRIPTION_EMAIL = ENV['SUBSCRIPTION_EMAIL'] || 'user@us.ibm.com'
SUBSCRIPTION_TYPE = ENV['SUBSCRIPTION_TYPE'] || 'trial'

SAAS_ENDPOINT_DELETE = 1
SAAS_ENDPOINT_GET = 2
SAAS_ENDPOINT_PATCH = 3
SAAS_ENDPOINT_POST = 4
SAAS_ENDPOINT_PUT = 5

def usage()
  puts("Usage: #{$PROGRAM_NAME} -c")
  puts("       Creates subscription")
  puts("Usage: #{$PROGRAM_NAME} -d sid")
  puts("       sid is subscription id")
  puts("       Deletes subscription")
  puts("Usage: #{$PROGRAM_NAME} -s sid")
  puts("       sid is subscription id")
  puts("       Searches for subscription")
  puts("Usage: #{$PROGRAM_NAME} -z id")
  puts("       id is database id")
end

def create_payload
  {
    'callbackURL' => SUBSCRIPTION_CALLBACK,
    'requestorEmail' => SUBSCRIPTION_EMAIL,
    'subscriptionID' => SecureRandom.hex,
    'subscriptionType' => SUBSCRIPTION_TYPE
  }
end

def patch_payload
  {
    'callbackURL' => SUBSCRIPTION_CALLBACK,
    'requestorEmail' => SUBSCRIPTION_EMAIL,
    'subscriptionType' => SUBSCRIPTION_TYPE
  }
end


##
# Search
def http_request(verb, uri, payload=nil)
  http_client = Net::HTTP.new(uri.host, uri.port)
  http_client.use_ssl = uri.scheme.downcase == 'https' 
  http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
  http_client.ssl_version = :TLSv1

  case verb
  when SAAS_ENDPOINT_DELETE
    request = Net::HTTP::Delete.new(uri)
  when SAAS_ENDPOINT_GET
    request = Net::HTTP::Get.new(uri)
  when SAAS_ENDPOINT_POST
    request = Net::HTTP::Post.new(uri)
  when SAAS_ENDPOINT_PATCH
    request = Net::HTTP::Patch.new(uri)
  when SAAS_ENDPOINT_PUT
    request = Net::HTTP::Put.new(uri)
  end
  request.basic_auth("#{SAAS_ENDPOINT_USER}", "#{SAAS_ENDPOINT_PASSWORD}")  
  request['Content-Type'] = 'application/json; charset=utf-8'
  request['Accept'] = 'application/json'
  request.body = payload.to_json if payload
  
  begin
    response = http_client.start { |client| client.request(request) }
    
    if (200...300).include?(response.code.to_i) && response.body
    begin
      puts(JSON.pretty_generate(JSON.parse(response.body)))
    rescue Exception => e
      puts(response.body)
    end
    end
  end
end
##

case ARGV[0]
when '-c'
  uri = URI("#{SAAS_ENDPOINT_SCHEME}://localhost:3000/api/v1/subscription")
  puts("INFO: uri #{uri}")
  http_request(SAAS_ENDPOINT_POST, uri, create_payload)
when '-d'
  uri = URI("#{SAAS_ENDPOINT_SCHEME}://localhost:3000/api/v1/subscriptions/#{ARGV[1]}/searches/1")
  puts("INFO: uri #{uri}")
  http_request(SAAS_ENDPOINT_DELETE, uri)
when '-p'
  uri = URI("#{SAAS_ENDPOINT_SCHEME}://localhost:3000/api/v1/subscriptions/#{ARGV[1]}/searches/1")
  puts("INFO: uri #{uri}")
  http_request(SAAS_ENDPOINT_PATCH, uri, patch_payload)
when '-s'
  uri = URI("#{SAAS_ENDPOINT_SCHEME}://localhost:3000/api/v1/subscriptions/#{ARGV[1]}/searches")
  puts("INFO: uri #{uri}")
  http_request(SAAS_ENDPOINT_GET, uri)
when '-z'
  uri = URI("#{SAAS_ENDPOINT_SCHEME}://localhost:3000/api/v1/subscriptions/#{ARGV[1]}")
  puts("INFO: uri #{uri}")
  http_request(SAAS_ENDPOINT_DELETE, uri)
else
  usage
  exit(1)
end
