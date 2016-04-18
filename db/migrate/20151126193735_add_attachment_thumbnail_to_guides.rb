class AddAttachmentThumbnailToGuides < ActiveRecord::Migration
  def self.up
    change_table :guides do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :guides, :thumbnail
  end
end
