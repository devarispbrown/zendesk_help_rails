require 'zendesk_api'
require 'json'

class HelpController < ApplicationController
  def tickets
  	@user = current_user.email

  	client = ZendeskAPI::Client.new do |config|

  		config.url = ENV['ZD_URL']
  		config.username = ENV['ZD_USER']
  		config.password = ENV['ZD_PASS']

  		config.retry = true

  		config.logger = Logger.new(STDOUT)
	end

	@tickets = client.search(:query => "requester:#{@user}")
  end

  def details
    @id = params[:id]
  end
end
