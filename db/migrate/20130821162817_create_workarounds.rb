class CreateWorkarounds < ActiveRecord::Migration
  def change
    create_table :workarounds do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :workarounds, :key
  end
end
