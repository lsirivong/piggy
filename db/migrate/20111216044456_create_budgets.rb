class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :amount

      t.timestamps
    end
    
    add_column :envelopes, :budget_percent, :decimal
    add_column :envelopes, :budget_id, :integer
  end
end
