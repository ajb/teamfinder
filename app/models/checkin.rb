class Checkin < ActiveRecord::Base
  belongs_to :location

  validates :location, presence: true
  validates :user, presence: true

  def self.most_recent_for_user(user)
    where(user: user).
    order('created_at DESC').
    first
  end
end
