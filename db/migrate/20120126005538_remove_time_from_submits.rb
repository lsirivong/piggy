class RemoveTimeFromSubmits < ActiveRecord::Migration
  def up
    change_table :submits do |t|
      t.remove :time
    end
  end

  def down
    change_table :submits do |t|
      t.datetime :time
    end
  end
end
