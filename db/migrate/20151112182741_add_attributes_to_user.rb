class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :description, :text
  end
end
