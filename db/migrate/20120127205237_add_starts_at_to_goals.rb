class AddStartsAtToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :starts_at, :date
  end
end
