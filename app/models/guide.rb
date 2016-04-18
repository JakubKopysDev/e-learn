class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes, dependent: :destroy
  self.per_page = 15
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :thumbnail, attachment_presence: true
  validates_attachment :thumbnail, content_Type: { content_type: ["image/jpeg", "image/png"] }
  has_attached_file :thumbnail, styles: { medium: "256x256", thumb: "300x300", small: "200x200>", hihi: "500x500" }
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\Z/
  validate :thumbnail_size
  has_attached_file :video, styles: {
                                                    :medium => { :geometry => "640x480",:format => 'mp4' },
                                                    :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10} },
                                                    processors: [:ffmpeg]
validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
validates_attachment_presence :video, message: "- no video file selceted."

  def votes
    votes = self.up_votes - self.down_votes
  end

  private

    # Validates the size of an uploaded image.
    def thumbnail_size
      unless thumbnail.size.nil?
        if thumbnail.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
        end
      end
    end
end
