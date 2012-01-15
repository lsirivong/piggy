class AddNameToEnvelopes < ActiveRecord::Migration
  def change
    add_column :envelopes, :name, :string
  end
end
