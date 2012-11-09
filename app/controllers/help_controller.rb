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

    client = ZendeskAPI::Client.new do |config|

      config.url = ENV['ZD_URL']
      config.username = ENV['ZD_USER']
      config.password = ENV['ZD_PASS']

      config.retry = true

      config.logger = Logger.new(STDOUT)
    end

    @comments = client.requests.find(:id => @id).comments
  end

  def comments
    @id = params[:id]
    @comment = params[:comment]

    client = ZendeskAPI::Client.new do |config|

      config.url = ENV['ZD_URL']
      config.username = ENV['ZD_USER']
      config.password = ENV['ZD_PASS']

      config.retry = true

      config.logger = Logger.new(STDOUT)
    end

    @update = client.requests.find(:id => @id)
    @update.comment = { :body => @comment}
    @update.save

    redirect_to details_path(@id)
  end
end
