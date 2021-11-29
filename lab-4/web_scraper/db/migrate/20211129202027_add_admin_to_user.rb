class AddAdminToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :student, :boolean, default: false
    add_column :users, :instructor, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
