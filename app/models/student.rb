class Student < ActiveRecord::Base
  has_many :assignments
  has_many :events
  has_many :teachers, through: :assignments
  has_many :teachers, through: :events
  belongs_to :admin

  def self.view_assignments(id)
    arr = []
    student = Student.find_by(id: id.to_i)
    assignment = student.assignments.each {|assignment|
      arr << [assignment.title, assignment.subject,  assignment.start_date, assignment.due_date, assignment.status, assignment.instruction]}
    arr
  end

  def self.submit_assignments(id,assignment)
    assignment = Assignment.find_by(student_id: id.to_i,title: assignment)
    assignment.status = "Completed"
    assignment.submission_date = Time.now
    assignment.save
  end

  def self.view_due_assignments(id)
    student = Assignment.where(student_id: id.to_i, status: "pending")
    assignment = student.map {|assignment| assignment.title}
  end

end
