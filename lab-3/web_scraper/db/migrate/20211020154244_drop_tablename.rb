class DropTablename < ActiveRecord::Migration[6.1]
  def change
    drop_table :catalogs
    drop_table :cses
  end
end
