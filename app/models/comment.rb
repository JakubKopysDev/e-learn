class Comment < ActiveRecord::Base
  belongs_to :guide
  belongs_to :user
  validates :body, length: { maximum: 200, minimum: 4, message: "Comment should be 4 to 200 letters long." }
  default_scope -> { order(created_at: :desc) }
end
