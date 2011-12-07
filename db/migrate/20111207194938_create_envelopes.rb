class CreateEnvelopes < ActiveRecord::Migration
  def change
    create_table :envelopes do |t|
      t.boolean :active

      t.timestamps
    end
  end
end
