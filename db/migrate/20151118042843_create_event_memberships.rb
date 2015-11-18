class CreateEventMemberships < ActiveRecord::Migration
  def change
    create_table :event_memberships do |t|
      t.integer :user_id, index: true
      t.integer :event_id, index: true
      t.integer :spots

      t.timestamps null: false
    end
  end
end
