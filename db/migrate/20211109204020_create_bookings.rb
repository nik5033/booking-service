class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :status
      t.integer :ticket_category
      t.date :event_date

      t.timestamps
    end
  end
end
