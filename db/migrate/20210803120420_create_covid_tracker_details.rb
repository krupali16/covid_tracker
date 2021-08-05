class CreateCovidTrackerDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :covid_tracker_details do |t|
      t.boolean :travel_history
      t.boolean :contact_with_covid_patient

      t.timestamps
    end
  end
end
