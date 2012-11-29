require 'zendesk_api'
require 'json'

class TicketsController < ApplicationController
  def new
    if user_signed_in?
      @profile = Profile.where(:email => current_user.email).first

      @game = if @profile
        Game.where(:profile_id => @profile.id).all
      else
        []
      end
    end
  end

  def create
    @email = params[:email]
    @game_name = Game.find(params[:game]).name if user_signed_in?
    @ticket = create_ticket
  end

  def index
    @user = current_user.email
    @tickets = client.search(:query => "requester:#{@user}")
  end

  def show
    @id = params[:id]
    @comments = client.requests.find(:id => @id).comments
  end

  def update
    @id = params[:id]
    @comment = params[:comment]

    @update = client.requests.find(:id => @id)
    @update.comment = { :body => @comment}
    @update.save

    redirect_to ticket_path(@id)
  end

  private

  def create_ticket
    options = {:subject => params[:subject], :comment => { :value => params[:body] }, :requester => { :email => @email }}
    if name
      options[:custom_fields] = {:id => "21833683", :value => @game_name}
    else
      options[:requester][:name] = params[:full_name]
    end
    ZendeskAPI::Ticket.create(client, options)
  end
end
