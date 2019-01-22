class CreateAssignmentTable < ActiveRecord::Migration[4.2]
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :subject
      t.string :instruction
      t.datetime :start_date
      t.datetime :due_date
      t.datetime :submission_date
      t.string :status
      t.integer :student_id
      t.integer :teacher_id
    end
  end
end
