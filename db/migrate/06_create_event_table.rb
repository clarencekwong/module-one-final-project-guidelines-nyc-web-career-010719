class CreateEventTable < ActiveRecord::Migration[4.2]
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :teacher_id
      t.string :student_id
      t.datetime :date
      t.datetime :purchase_date
    end
  end
end
