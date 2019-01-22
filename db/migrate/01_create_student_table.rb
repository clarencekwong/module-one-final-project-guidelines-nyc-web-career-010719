class CreateStudentTable < ActiveRecord::Migration[4.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :module
      t.string :gender
      t.integer :age
    end
  end
end
