class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :guides, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :username, presence: true, length: { minimum: 5 }
  has_attached_file :avatar, styles: { small: "70x70!", medium: "256x256!" }, default_url: "avatar_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def admin?
    admin
  end

  def up_voted?(guide)
    vote = Vote.find_by(user_id: self.id, guide_id: guide.id)
    return false if vote.nil?
    return true if vote.has_attribute?(:up_vote) && vote.up_vote
  end

  def down_voted?(guide)
    vote = Vote.find_by(user_id: self.id, guide_id: guide.id)
    return false if vote.nil?
    return true if vote.has_attribute?(:up_vote) && vote.up_vote == false
  end

  def points
    sum = 0
    guides.each { |guide| sum += guide.votes }
    sum
  end

end
