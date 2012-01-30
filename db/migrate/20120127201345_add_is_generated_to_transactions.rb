class AddIsGeneratedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :is_generated, :boolean, :default => false
  end
end
