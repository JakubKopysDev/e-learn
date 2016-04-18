class AddAttachmentVideoToGuides < ActiveRecord::Migration
  def self.up
    change_table :guides do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :guides, :video
  end
end
