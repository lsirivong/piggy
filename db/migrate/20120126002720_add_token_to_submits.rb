class AddTokenToSubmits < ActiveRecord::Migration
  def change
    add_column :submits, :token, :string
  end
end
