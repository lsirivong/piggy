class AddIsActiveStatusToGoals < ActiveRecord::Migration
  def up
    add_column :goals, :is_active, :boolean, :default => true

    Goal.reset_column_information
    Goal.all.each do |g|
      g.update_attributes(:is_active => true)
    end
  end

  def down
    remove_column :goals, :is_active
  end
end
