class AddFqdnToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :fqdn, :string
  end
end
