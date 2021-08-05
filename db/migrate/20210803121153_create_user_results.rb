class CreateUserResults < ActiveRecord::Migration[6.1]
  def change
    create_table :user_results do |t|
      t.boolean :has_covid

      t.timestamps
    end
    add_reference :user_results, :user, index: true
    add_reference :user_results, :zone, index: true
  end
end
