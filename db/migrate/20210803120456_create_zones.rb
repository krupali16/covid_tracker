class CreateZones < ActiveRecord::Migration[6.1]
  def change
    create_table :zones do |t|
      t.string :pincode
      t.integer :covid_patient_count
      
      t.timestamps
    end
  end
end
