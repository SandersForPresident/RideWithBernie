class ChangeEventidAndEventtitleFormat < ActiveRecord::Migration
  def change
    rename_column :profiles, :eventId, :event_id
    rename_column :profiles, :eventTitle, :event_title
  end
end
