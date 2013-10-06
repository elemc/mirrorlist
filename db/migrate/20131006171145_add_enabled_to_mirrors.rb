class AddEnabledToMirrors < ActiveRecord::Migration
  def change
    add_column :mirrors, :enabled, :boolean
  end
end
