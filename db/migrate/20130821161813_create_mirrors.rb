class CreateMirrors < ActiveRecord::Migration
  def change
    create_table :mirrors do |t|
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
