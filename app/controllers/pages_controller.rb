require 'zendesk_api'
require 'logger'

class PagesController < ApplicationController

  	def help
      if user_signed_in?
        @profile = Profile.where(:email => current_user.email).first

        if @profile
          @game = Game.where(:profile_id => @profile.id).all
        else
          @game = []
        end
      end
  	end

  	def success
      if user_signed_in?
        @email = params[:email]
        @subject = params[:subject]
        @body = params[:body]
        @game = params[:game]
        @name = Game.find(@game).name
      else
  		  @full_name = params[:full_name]
  		  @email = params[:email]
  		  @subject = params[:subject]
  		  @body = params[:body]
      end

  		client = ZendeskAPI::Client.new do |config|

  			config.url = ENV['ZD_URL']
  			config.username = ENV['ZD_USER']
  			config.password = ENV['ZD_PASS']

  			config.retry = true

  			config.logger = Logger.new(STDOUT)
		  end

      if user_signed_in?
        @ticket = ZendeskAPI::Ticket.create(client, :subject => @subject, :comment => { :value => @body }, :requester => {:email => @email}, :custom_fields => {:id => "21833683", :value => @name})
      else
		    @ticket = ZendeskAPI::Ticket.create(client, :subject => @subject, :comment => { :value => @body }, :requester => { :name => @full_name, :email => @email})
      end
  	end
end
