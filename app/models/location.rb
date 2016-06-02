class Location < ActiveRecord::Base
  has_many :checkins, dependent: :nullify

  validates :mac_address, presence: true
end
