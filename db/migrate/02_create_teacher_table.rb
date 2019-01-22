class CreateTeacherTable < ActiveRecord::Migration[4.2]
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.integer :age
    end
  end
end
