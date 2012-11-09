class Game < ActiveRecord::Base
  attr_accessible :description, :name, :profile_id
  belongs_to :profile
end
