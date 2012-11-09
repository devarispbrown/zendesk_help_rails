class AddProfileIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :profile_id, :integer
  end
end
