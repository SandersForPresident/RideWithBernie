class Profile < ActiveRecord::Base
  has_many :event_memberships
  has_many :events, through: :event_memberships

  before_create :set_uuid

protected

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
