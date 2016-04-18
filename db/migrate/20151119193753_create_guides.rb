class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :title
      t.text :description
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :guides, :users
  end
end
