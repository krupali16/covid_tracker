class CreateRiskCalculationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :risk_calculation_details do |t|
      t.boolean :travel_history
      t.boolean :contact_with_covid_patient
      t.integer :min_symptom_count
      t.integer :max_symptom_count
      t.integer :risk_percent

      t.timestamps
    end
  end
end
