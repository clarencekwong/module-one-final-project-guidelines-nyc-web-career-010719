class Teacher < ActiveRecord::Base
  has_many :assignments
  has_many :students, through: :assignments

  def self.view_assignments(id)
    arr = []
    teacher = Teacher.find_by(id: id.to_i)
    assignment = teacher.assignments.each {|assignment|
      arr << [assignment.title, assignment.subject, assignment.start_date,     assignment.due_date, assignment.status]}
    arr
  end

  def self.add_assignments(id)
    assignment = Assignment.create(title: nil,subject: nil,instruction: nil,start_date: nil,due_date: nil,submission_date: nil,status: "pending",student_id: nil,teacher_id: id.to_i)
    puts "Enter Assignment title: "
    assignment.title = gets.chomp.capitalize
    puts "Enter Assignment subject: "
    assignment.subject = gets.chomp
    puts "Enter Assignment instructions: "
    assignment.instruction = gets.chomp
    puts "Enter Assignment start date: YY-MM-DD"
    assignment.start_date = gets.chomp
    puts "Enter Assignment due date: YY-MM-DD"
    assignment.due_date = gets.chomp
    puts "Assign to student_id: "
    assignment.student_id = gets.chomp
    assignment.save
    puts "Assignment added"
  end

  def self.find_assignment_by_teacher(id, assignment)
    Assignment.find_by(teacher_id: id.to_i,title: assignment)
  end

  def self.update_title(id, assignment, title)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.title = title
    assignment.save
  end

  def self.update_subject(id, assignment, subject)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.subject = subject
    assignment.save
  end

  def self.update_instructions(id, assignment, description)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.instruction = description
    assignment.save
  end

  def self.update_start_date(id, assignment, date)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.start_date = date
    assignment.save
  end

  def self.update_due_date(id, assignment, date)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.due_date = date
    assignment.save
  end

  def self.update_status(id, assignment, status)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.status = status
    assignment.save
  end

  def self.update_student_id(id, assignment, student_id)
    assignment = find_assignment_by_teacher(id, assignment)
    assignment.student_id = student_id
    assignment.save
  end

  def self.delete_assignment(id, assignment)
    assignment = find_assignment_by_teacher(id, assignment)
    Assignment.destroy(assignment)
  end

end
