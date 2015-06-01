class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, index: true
  end
end
