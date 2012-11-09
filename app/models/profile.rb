class Profile < ActiveRecord::Base
  attr_accessible :email, :username
  has_many :games
end
