require 'zendesk_api'
require 'logger'

class PagesController < ApplicationController

  	def help
  	end

  	def success
  		@full_name = params[:full_name]
  		@email = params[:email]
  		@subject = params[:subject]
  		@body = params[:body]

  		client = ZendeskAPI::Client.new do |config|

  			config.url = ENV['ZD_URL']
  			config.username = ENV['ZD_USER']
  			config.password = ENV['ZD_PASS']

  			config.retry = true

  			config.logger = Logger.new(STDOUT)
		end

		@ticket = ZendeskAPI::Ticket.create(client, :subject => @subject, :comment => { :value => @body }, :requester => { :name => @full_name, :email => @email})

  	end
end
