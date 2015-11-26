class AddProfilesContactedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profiles_contacted, :json
  end
end
