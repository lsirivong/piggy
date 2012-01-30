class AddIsRecurringAndRecurranceTypeToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :is_recurring, :boolean, :default => false
    add_column :goals, :recurrance_type, :string
  end
end
