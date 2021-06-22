class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :type
      t.references :user
      t.date :happens_on
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :name
      t.string :location
      t.text :description
      t.integer :max_attendees
      t.timestamps
    end
  end
end
