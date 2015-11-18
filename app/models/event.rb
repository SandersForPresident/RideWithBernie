class Event < ActiveRecord::Base
  has_many :event_memberships
  has_many :profiles, through: :event_memberships
end
