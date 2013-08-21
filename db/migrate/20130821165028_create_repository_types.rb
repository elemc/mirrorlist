class CreateRepositoryTypes < ActiveRecord::Migration
  def change
    create_table :repository_types do |t|
      t.string :rtype
      t.string :path_part

      t.timestamps
    end
    add_index :repository_types, :rtype
  end
end
