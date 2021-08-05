class CreateCovidSymptoms < ActiveRecord::Migration[6.1]
  def change
    create_table :covid_symptoms do |t|
      t.integer :symptom

      t.timestamps
    end
    add_reference :covid_symptoms, :covid_tracker_detail, index: true
  end
end
