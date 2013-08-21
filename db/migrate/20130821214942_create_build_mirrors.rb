class CreateBuildMirrors < ActiveRecord::Migration
  def change
    create_table :build_mirrors do |t|
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
