class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def client
    FooClient.instance
  end
end

class FooClient < ZendeskAPI::Client
  def self.instance
    @instance ||= new do |config|
      config.url = ENV['ZD_URL']
      config.username = ENV['ZD_USER']
      config.password = ENV['ZD_PASS']

      config.retry = true

      config.logger = Rails.logger
    end
  end

  def tickets(email)
    search(:query => "requester:#{email}")
  end
end