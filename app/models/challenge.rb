class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge_partner

  validates :user_id, presence: true
  validates :challenge_partner_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.search(q)
    q = Sanitize.fragment(q)
    where('title ILIKE ? OR description ILIKE ?', "%#{q}%", "%#{q}%")
  end
end
