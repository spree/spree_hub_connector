class AddStoreNameToAuguryEnvironment < ActiveRecord::Migration
  def change
    add_column :augury_environments, :store_name, :string
  end
end
