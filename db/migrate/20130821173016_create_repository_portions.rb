class CreateRepositoryPortions < ActiveRecord::Migration
  def change
    create_table :repository_portions do |t|
      t.string :name
      t.string :url_part

      t.timestamps
    end
    add_index :repository_portions, :name
  end
end
