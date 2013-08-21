class CreateRepositoryVariants < ActiveRecord::Migration
  def change
    create_table :repository_variants do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :repository_variants, :name
  end
end
