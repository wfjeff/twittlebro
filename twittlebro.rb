require 'rubygems'
require 'oauth'
require 'json'
require 'pp'
require 'pry'

# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.
consumer_key = OAuth::Consumer.new(
    "6nDgvS4rYK1Qat1xABilg",
    "fKicPvXAi3VKlpcZV2g9wgiLAdYSrBFlXXu69tP40")
access_token = OAuth::Token.new(
    "19941550-RnFgGzawRaPPzdfeuF1PLCVSZ6rX07KOWmXymNdRI",
    "AHQzu9ZKjc0wl0iRdegXlQJcJYX8yDHkaFSms4BbXyc")

baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/update.json"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post.new address.request_uri
request.set_form_data(
  "status" => "fancy!",
)

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweet = nil
if response.code == '200' then
  tweet = JSON.parse(response.body)
  puts "Successfully sent #{tweet["text"]}"
else
  puts "Could not send the Tweet! " +
  "Code:#{response.code} Body:#{response.body}"
end
