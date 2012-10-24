require 'zendesk_api'

class HelpController < ApplicationController
  def tickets
  	@user = current_user.email

  end
end
