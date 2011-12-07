class ChangeScaleOfAmountColumn < ActiveRecord::Migration
  def up
    change_column :transactions, :amount, :decimal, :scale => 2 
  end

  def down
    # The default scale for decimal columns varies per RDBMS's.
    # The default for many is 0, but this isn't guaranteed
    change_column :transactions, :amount, :decimal, :scale => nil
  end
end
