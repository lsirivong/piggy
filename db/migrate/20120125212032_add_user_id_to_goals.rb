class AddUserIdToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :user_id, :integer
  end
end
