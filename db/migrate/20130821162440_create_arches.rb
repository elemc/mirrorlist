class CreateArches < ActiveRecord::Migration
  def change
    create_table :arches do |t|
      t.string :name

      t.timestamps
    end
    add_index :arches, :name
  end
end
