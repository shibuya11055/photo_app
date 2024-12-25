require 'net/http'
require 'uri'
require 'json'

class MyTweetAppPostService
  def self.call(title, image_url, access_token, post_url)
    new(title, image_url, access_token, post_url).call
  end

  def initialize(title, image_url, access_token, post_url)
    @title = title
    @image_url = image_url
    @access_token = access_token
    @post_url = post_url
  end

  def call
    uri = URI.parse(@post_url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.path, {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@access_token}"
    })

    request.body = {
      text: @title,
      url: @image_url
    }.to_json

    http.request(request)
  end
end
