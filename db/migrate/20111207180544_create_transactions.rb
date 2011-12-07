class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :vendor
      t.text :desc
      t.decimal :amount

      t.timestamps
    end
  end
end
