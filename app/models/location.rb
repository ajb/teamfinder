class Location < ActiveRecord::Base
  has_many :checkins, dependent: :nullify
  has_many :location_names, dependent: :destroy

  validates :mac_address, presence: true

  def most_recent_name
    location_names.order('created_at DESC').first
  end

  def name
    most_recent_name.try(:name)
  end
end
