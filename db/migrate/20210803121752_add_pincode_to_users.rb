class AddPincodeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pincode, :string
  end
end
