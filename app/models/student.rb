class Student < ActiveRecord::Base
  has_many :assignments
  has_many :teachers, through: :assignments

  def self.view_assignments(id)
    arr = []
    student = Student.find_by(id: id.to_i)
    assignment = student.assignments.map {|assignment|
      arr << [assignment.title, assignment.subject,  assignment.start_date,     assignment.due_date, assignment.status]}
    arr
    #   arr << assignment
    # }
    # arr.map {|assignment|
    #   binding.pry
    #   assignment
    # }
  end

end
