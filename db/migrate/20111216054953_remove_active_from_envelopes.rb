class RemoveActiveFromEnvelopes < ActiveRecord::Migration
  def up
    remove_column :envelopes, :active
  end

  def down
    add_column :envelopes, :active, :boolean
  end
end
