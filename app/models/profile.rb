class Profile < ActiveRecord::Base
  before_create :set_uuid

protected

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
