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
  #find_by id
  Student.find_by(id: "#{input}")
end

def id_submit
  puts "Please input your ID"
  id_input = gets.chomp
  id_input
  # Please input your id
  # find person based on id find_by
  # Welcome first_name last_name what would you like to do today?
  # welcome_function
  # Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
  # Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

  # NICE TO HAVES: STUDENTS: SEE PENDING/COMPLETED/FAILED ASSIGNMENTS, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY subject
  # TEACHERS: SEE PENDING/COMPLETED/FAILED FOR CERTAIN STUDENTS/MODULE, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY SUBJECT, SEE LATE ASSIGNMENTS,
end

def person_finder(input)
  if input == 1
    Student.find_by(id: "#{input}")
  else
    Teacher.find_by(id: "#{input}")
  end
end

def main_menu
  input = user_type
  id_input = id_submit
  person = person_finder(id_input)
  puts "Welcome, #{person.first_name} #{person.last_name} what would you like to do?"
  table_of_contents(input)
  action = gets.chomp
  do_action(action,input)
end

# store as an object, or keep as id? make changes in ruby then save it to the database
# object when calling will refer to self. making changes to the database every time
# keep as id, refer class methods where Class.id = id input
# Assignment.all.find().where(id: id)

def do_action(action,input)
  if action == "1"
    puts Student.view_assignments(input)
  end
end

def table_of_contents(input)
  # Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
  # Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

  if input == "1"
    puts "1. View Assignments"
    puts "2. Submit Assignments"
    puts "3. BLAH"
    puts "4. BLAH"
    puts "5. BLAH"
  else input == "2"
    puts "1. View Assignments"
    puts "2. Add Assignments"
    puts "3. Update Assignment Info"
    puts "4. Update Assignment Status"
    puts "5. Delete Assignment"
  end
end
