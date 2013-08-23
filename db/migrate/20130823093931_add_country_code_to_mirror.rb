class AddCountryCodeToMirror < ActiveRecord::Migration
  def change
    add_column :mirrors, :country_code, :string
  end
end
