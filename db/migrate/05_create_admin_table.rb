class CreateAdminTable < ActiveRecord::Migration[4.2]
  def change
    create_table :admins do |t|
      t.integer :student_id
      t.integer :teacher_id
    end
  end
end
