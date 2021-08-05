class AddUserToCovidTrackerDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :covid_tracker_details, :user, :integer
  end
end
