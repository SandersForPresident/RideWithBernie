class AddUuidIndex < ActiveRecord::Migration
  def change
    add_index :profiles, :uuid
  end
end
