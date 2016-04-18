class AddVotesCountToUsersAndGuides < ActiveRecord::Migration
  def change
    add_column :users, :up_votes, :integer, :null => false, default: 0
    add_column :users, :down_votes, :integer, :null => false, default: 0
    add_column :guides, :up_votes, :integer, :null => false, default: 0
    add_column :guides, :down_votes, :integer, :null => false, default: 0
  end
end
