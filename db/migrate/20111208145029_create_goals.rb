class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.date :deadline
      t.decimal :amount

      t.timestamps
    end
    
    add_column :transactions, :goal_id, :integer
  end
end
