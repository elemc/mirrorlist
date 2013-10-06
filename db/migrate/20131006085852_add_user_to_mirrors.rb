class AddUserToMirrors < ActiveRecord::Migration
  def change
    add_reference :mirrors, :user, index: true
  end
end
