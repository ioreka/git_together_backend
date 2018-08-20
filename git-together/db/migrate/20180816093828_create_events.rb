class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :group_name
      t.string :description
      t.string :local_date
      t.string :local_time
      t.string :address
      t.integer :meetup_id
      t.string :meetup_link

      t.timestamps
    end
  end
end
