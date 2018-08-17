class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :group_name
      t.string :description
      t.string :date
      t.string :time
      t.string :venue_address
      t.integer :meetup_id

      t.timestamps
    end
  end
end
