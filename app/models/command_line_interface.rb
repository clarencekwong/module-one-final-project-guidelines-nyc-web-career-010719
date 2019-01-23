# Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
# Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

# NICE TO HAVES: STUDENTS: SEE PENDING/COMPLETED/FAILED ASSIGNMENTS, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY subject
# TEACHERS: SEE PENDING/COMPLETED/FAILED FOR CERTAIN STUDENTS/MODULE, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY SUBJECT, SEE LATE ASSIGNMENTS,

def user_type
  puts "Welcome User, please identify yourself as: 1. Student, 2. Teacher"
  input = gets.chomp
  if input == "1" || input == "2"
    input
  else
    puts "Please enter an appropriate answer."
    user_type
  end
end

def verify_id(input)
  Student.find_by(id: "#{input}")
end

def id_submit
  puts "Please input your ID"
  id_input = gets.chomp
  id_input
end

def person_finder(input)
  if input == 1
    Student.find_by(id: "#{input}")
  else
    Teacher.find_by(id: "#{input}")
  end
end

def initial_boot
  input = user_type
  id_input = id_submit
  person = person_finder(id_input)
  if person
    puts "Welcome, #{person.first_name} #{person.last_name} what would you like to do?"
  else
    puts "Please enter an existing ID"
    initial_boot
  end
  main_menu(input)
end

def main_menu(input)
  table_of_contents(input)
  action = gets.chomp
  if input == "1"
    student_actions(action,input)
  else
    teacher_actions(action,input)
  end
end

# store as an object, or keep as id? make changes in ruby then save it to the database
# object when calling will refer to self. making changes to the database every time
# keep as id, refer class methods where Class.id = id input
# Assignment.all.find().where(id: id)

def student_view(input)
  Student.view_assignments(input).map {|assignment|
    puts "Assignment: #{assignment[0]} Subject: #{assignment[1]} Start Date: #{assignment[2]} End Date: #{assignment[3]} Status: #{assignment[4]}"
    puts "***********************************************************"
  }
end

def student_submission(input)
  student_view(input)
  puts "Please specify which lab you are going to submit, if you wish to return to the main menu type in back"
  user_input = gets.chomp.capitalize
  assignment = Assignment.find_by(student_id: input.to_i,title: user_input)
  if user_input == "Back"
    main_menu(input)
  elsif assignment
    if assignment.status == "Completed"
      Student.submit_assignments(input,user_input)
      puts "Thank you for your re-submission"
      student_submission(input)
    elsif assignment.status == "pending"
      Student.submit_assignments(input,user_input)
      puts "Thank you for your submission"
      student_submission(input)
    end
  else
    puts "Please make sure to submit an appropriate assignment"
    student_submission(input)
  end
end

def student_actions(action,input)
  if action == "1"
    student_view(input)
    main_menu(input)
  elsif action == "2"
    student_submission(input)
  elsif action == "5"
    initial_boot
  end
end


def teacher_actions(action,input)
  if action == "1"

    main_menu(input)
  elsif action == "2"

  elsif action == "6"
    initial_boot
  end
end

def table_of_contents(input)
  # Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
  # Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

  if input == "1"
    puts "1. View Assignments"
    puts "2. Submit Assignments"
    puts "3. WIP"
    puts "4. WIP"
    puts "5. Log off"
    puts "6. Exit"
  else input == "2"
    puts "1. View Assignments"
    puts "2. Add Assignments"
    puts "3. Update Assignment Info"
    puts "4. Update Assignment Status"
    puts "5. Delete Assignment"
    puts "6. Log off"
    puts "7. Exit"
  end
end
