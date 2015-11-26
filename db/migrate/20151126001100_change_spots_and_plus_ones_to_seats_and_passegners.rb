class ChangeSpotsAndPlusOnesToSeatsAndPassegners < ActiveRecord::Migration
  def change
    rename_column :profiles, :spots, :seats
    rename_column :profiles, :plus_ones, :passengers
  end
end
