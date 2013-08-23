class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :country_code
      t.string :city
      t.string :repo
      t.string :arch
      t.integer :count

      t.timestamps
    end
  end
end
