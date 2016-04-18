class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :guide, index: true
      t.boolean :up_vote, :null => false

      t.timestamps null: false
    end
  end
end
