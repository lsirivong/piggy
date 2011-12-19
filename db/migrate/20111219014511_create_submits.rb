class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
      t.timestamp :time

      t.timestamps
    end
  end
end
