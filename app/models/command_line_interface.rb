# Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
# Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

# NICE TO HAVES: STUDENTS: SEE PENDING/COMPLETED/FAILED ASSIGNMENTS, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY subject
# TEACHERS: SEE PENDING/COMPLETED/FAILED FOR CERTAIN STUDENTS/MODULE, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY SUBJECT, SEE LATE ASSIGNMENTS,

# *****************************************************************************
# MAIN PAGE
# *****************************************************************************

def user_type
  puts "Welcome User, please identify yourself as: 1. Student, 2. Teacher, 3. Admin \nPut exit or quit to back out."
  input = gets.chomp
  if input == "1" || input == "2"
    input
  elsif input == "exit" || input == "quit"
    exit!
  elsif input == "3"
    puts "Please enter password: "
    password = STDIN.noecho(&:gets).chomp
    if password == "password"
      input
    else
      puts "Wrong password"
      user_type
    end
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

def person_finder(input,id_input)
  if input == "1"
    Student.find_by(id: "#{id_input}")
  elsif input == "2"
    Teacher.find_by(id: "#{id_input}")
  else
    return
  end
end

def initial_boot
  type_of_user = user_type
  if type_of_user == "1" || type_of_user == "2"
    id_input = id_submit
  else
    id_input = "3"
  end
  person = person_finder(type_of_user,id_input)
  if person
    puts "Welcome, #{person.first_name} #{person.last_name} what would you like to do?"
  elsif type_of_user == "3"
    puts "Welcome, Admin, what would you like to do?"
  else
    puts "Please enter an existing ID"
    initial_boot
  end
  main_menu(type_of_user, id_input)
end

def main_menu(type_of_user, id_input)
  table_of_contents(type_of_user)
  action = gets.chomp
  if type_of_user == "1"
    student_actions(action, id_input, type_of_user)
  elsif type_of_user == "2"
    teacher_actions(action, id_input, type_of_user)
  else
    admin_actions(action,id_input, type_of_user)
  end
end

def table_of_contents(input)
# Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
# Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

  if input == "1"
    puts "*******************************"
    puts "1. View Assignments"
    puts "2. Submit Assignments"
    puts "3. View Pending Assignments"
    puts "4. Events"
    puts "5. Log off"
    puts "6. Exit"
    puts "*******************************"
  elsif input == "2"
    puts "*******************************"
    puts "1. View Assignments"
    puts "2. Add Assignments"
    puts "3. Update Assignment Info"
    puts "4. Delete Assignment"
    puts "5. Log off"
    puts "6. Exit"
    puts "*******************************"
  else
    puts "*******************************"
    puts "1. View Students"
    puts "2. Create Student"
    puts "3. Update Student"
    puts "4. Delete Student"
    puts "5. View Teachers"
    puts "6. Create Teacher"
    puts "7. Update Teacher"
    puts "8. Delete Teacher"
    puts "9. Log off"
    puts "10. Exit"
    puts "*******************************"
  end
end

# store as an object, or keep as id? make changes in ruby then save it to the database
# object when calling will refer to self. making changes to the database every time
# keep as id, refer class methods where Class.id = id input
# Assignment.all.find().where(id: id)


# *****************************************************************************
# ADMIN
# *****************************************************************************

def admin_actions(action,id_input, type_of_user)
  if action == "1"
    students_view(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "2"
    Admin.create_student(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "3"
    students_view(id_input)
    update_student(type_of_user, id_input)
    main_menu(type_of_user, id_input)
  elsif action == "4"
    students_view(id_input)
    Admin.delete_student(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "5"
    teachers_view(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "6"
    Admin.create_teacher(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "7"
    teachers_view(id_input)
    update_teacher(type_of_user, id_input)
    main_menu(type_of_user, id_input)
  elsif action == "8"
    teachers_view(id_input)
    Admin.delete_teacher(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "9"
    initial_boot
  elsif action == "10"
    exit!
  else
    main_menu(type_of_user, id_input)
  end
end

def students_view(input)
  Student.all.map {|student|
    puts "Student: ID: #{student.id} First Name: #{student.first_name} Last Name: #{student.last_name} Module: #{student.module} Gender: #{student.gender} Age: #{student.age}}"
    puts "***********************************************************"
  }
end

def teachers_view(input)
  Teacher.all.map {|teacher|
    puts "Teacher: ID: #{teacher.id} First Name: #{teacher.first_name} Last Name: #{teacher.last_name} Gender: #{teacher.gender} Age: #{teacher.age}}"
    puts "***********************************************************"
  }
end

def update_student(type_of_user, student_id)
  puts "What student id do you want to change?"
  change_student = gets.chomp
  student = Admin.find_student(change_student)
  puts "What do you want to update?"
  puts "1. First name"
  puts "2. Last name"
  puts "3. Module"
  puts "4. Gender"
  puts "5. Age"
  puts "6. Back"
  input = gets.chomp
  if input == "1"
    puts "Enter new first name"
    change = gets.chomp.capitalize
    student.first_name = change
  elsif input == "2"
    puts "Enter new last name: "
    change = gets.chomp.capitalize
    student.last_name = change
  elsif input == "3"
    puts "Enter module: "
    change = gets.chomp
    student.module = change
  elsif input == "4"
    puts "Enter gender: "
    change = gets.chomp.capitalize
    student.gender = change
  elsif input == "5"
    puts "Enter new age: "
    change = gets.chomp
    student.age = change
  elsif input == "6"
    main_menu(type_of_user, student_id)
  end
  student.save
  puts "Student updated"
end

def update_teacher(type_of_user, teacher_id)
  puts "What teacher id do you want to change?"
  change_teacher = gets.chomp
  teacher = Admin.find_teacher(change_teacher)
  puts "What do you want to update?"
  puts "1. First name"
  puts "2. Last name"
  puts "3. Gender"
  puts "4. Age"
  puts "5. Back"
  input = gets.chomp
  if input == "1"
    puts "Enter new first name"
    change = gets.chomp.capitalize
    teacher.first_name = change
  elsif input == "2"
    puts "Enter new last name: "
    change = gets.chomp.capitalize
    teacher.last_name = change
  elsif input == "3"
    puts "Enter gender: "
    change = gets.chomp
    teacher.gender = change
  elsif input == "4"
    puts "Enter new age: "
    change = gets.chomp
    teacher.age = change
  elsif input == "5"
    main_menu(type_of_user, teacher_id)
  end
  teacher.save
  puts "Teacher updated"
end


# *****************************************************************************
# STUDENT
# *****************************************************************************

def student_view(input)
  Student.view_assignments(input).map {|assignment|
    puts "Assignment: #{assignment[0]} Subject: #{assignment[1]} Start Date: #{assignment[2]} End Date: #{assignment[3]} Status: #{assignment[4]} \nInstruction: #{assignment[5]}"
    puts "***********************************************************"
  }
end

def student_submission(type_of_user, input)
  student_view(input)
  puts "Please specify which lab you are going to submit, if you wish to return to the main menu type in back"
  user_input = gets.chomp.capitalize
  assignment = Assignment.find_by(student_id: input.to_i,title: user_input)
  if user_input == "Back"
    main_menu(type_of_user, input)
  elsif assignment
    if assignment.status == "Completed"
      Student.submit_assignments(input,user_input)
      puts "Thank you for your re-submission"
      student_submission(type_of_user, input)
    elsif assignment.status == "pending"
      Student.submit_assignments(input,user_input)
      puts "Thank you for your submission"
      student_submission(type_of_user, input)
    else
      return
    end
  else
    puts "Please make sure to submit an appropriate assignment"
    student_submission(type_of_user, input)
  end
end

def view_assignments_pending(id_input)
  pending_exist = Assignment.where(student_id: id_input.to_i, status: "pending")
  if pending_exist.length > 0
    Student.view_due_assignments(id_input).map {|assignment| puts "Pending Assignment: #{assignment}"}
    puts "***********************************************************"
  else
    puts "No assignments due."
    puts "***********************************************************"
  end
end

def student_actions(action,id_input, type_of_user)
  if action == "1"
    student_view(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "2"
    student_submission(type_of_user, id_input)
  elsif action == "3"
    view_assignments_pending(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "4"
    event_action(type_of_user,id_input)
  elsif action == "5"
    initial_boot
  elsif action == "6"
    exit!
  else
    main_menu(type_of_user, id_input)
  end
end

# *****************************************************************************
# TEACHER
# *****************************************************************************

def teacher_actions(action,id_input, type_of_user)
  if action == "1"
    teacher_view(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "2"
    Teacher.add_assignments(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "3"
    teacher_view(id_input)
    puts "Which lab do you wish to update? Put cancel if you wish to abort making any changes."
    assignment = gets.chomp.capitalize
    assignment_by_teacher = Teacher.find_assignment_by_teacher(id_input,assignment)
    if assignment_by_teacher
      teacher_update_info_menu(id_input,assignment,action,type_of_user)
    elsif assignment == "Cancel"
      main_menu(type_of_user, id_input)
    else
      puts "Put in a valid assignment"
      teacher_actions(action,id_input, type_of_user)
    end
  elsif action == "4"
    teacher_view(id_input)
    puts "Which lab do you wish to delete? If you wish to return, please type in back."
    assignment = gets.chomp.capitalize
    assignment_by_teacher = Teacher.find_assignment_by_teacher(id_input,assignment)
    if assignment_by_teacher
      Teacher.delete_assignment(id_input,assignment)
      puts "Lab deleted"
      main_menu(type_of_user, id_input)
    elsif assignment == "Back"
      main_menu(type_of_user, id_input)
    else
      puts "Put in a valid assignment"
      teacher_actions(action,id_input, type_of_user)
    end
  elsif action == "5"
    initial_boot
  elsif action == "6"
    exit!
  else
    main_menu(type_of_user, id_input)
  end
end

def teacher_view(input)
  Teacher.view_assignments(input).map {|assignment|
    puts "Assignment: #{assignment[0]} Subject: #{assignment[1]} Start Date: #{assignment[2]} End Date: #{assignment[3]} Status: #{assignment[4]}"
    puts "***********************************************************"
  }
end

def teacher_update_info_menu(id_input,assignment,action,type_of_user)
  teacher_update_menu
  update_input = gets.chomp
  update_assignment(update_input,id_input,assignment,type_of_user)
  puts "Assignment updated"
  teacher_update_info_menu(id_input,assignment,action,type_of_user)
end

def update_assignment(update_input, id_input, assignment,type_of_user)
  if update_input == "1"
    puts "Update Assignment title: "
    input = gets.chomp
    Teacher.update_title(id_input,assignment,input)
  elsif update_input == "2"
    puts "Update Assignment subject: "
    input = gets.chomp
    Teacher.update_instructions(id_input,assignment,input)
  elsif update_input == "3"
    puts "Update Assignment instructions: "
    input = gets.chomp
    Teacher.update_instructions(id_input,assignment,input)
  elsif update_input == "4"
    puts "Update Assignment start date: YY-MM-DD"
    input = gets.chomp
    Teacher.update_start_date(id_input,assignment,input)
  elsif update_input == "5"
    puts "Update Assignment due date: YY-MM-DD"
    input = gets.chomp
    Teacher.update_due_date(id_input,assignment,input)
  elsif update_input == "6"
    puts "Update Assignment status: "
    input = gets.chomp
    Teacher.update_status(id_input,assignment,input)
  elsif update_input == "7"
    puts "Update student_id: "
    input = gets.chomp
    Teacher.update_student_id(id_input,assignment,input)
  else
    main_menu(type_of_user, id_input)
  end
end

def teacher_update_menu
  puts "***********************************************************"
  puts "1. Update title"
  puts "2. Update subject"
  puts "3. Update instructions"
  puts "4. Update start date"
  puts "5. Update due date"
  puts "6. Update status"
  puts "7. Update student id"
  puts "8. Back"
  puts "***********************************************************"
end

# *****************************************************************************
# EVENT
# *****************************************************************************

def event_action(type_of_user,id_input)
  puts "Select an option below"
  event_update_menu
  event_action = gets.chomp
  if event_action == "1"
    get_events_from_keyword(type_of_user,id_input)
  elsif event_action == "2"
    event_viewer(id_input)
    event_action(type_of_user,id_input)
  elsif event_action == "3"
    if Event.find_by(student_id: id_input)
      rec_event = Event.recent_event(id_input)
      puts "#{rec_event[0]} : #{rec_event[1]}"
      event_action(type_of_user,id_input)
    else
      puts "Please add events to your account"
      event_action(type_of_user,id_input)
    end
  elsif event_action == "4"
    event_viewer(id_input)
    Event.delete_event(id_input)
    event_action(type_of_user,id_input)
  elsif event_action == "5"
    if Event.find_by(student_id: id_input)
      cheap_event = Event.cheapest_event(id_input)
      puts "#{cheap_event[0]} : $#{cheap_event[1]}"
      event_action(type_of_user,id_input)
    else
      puts "Please add events to your account"
      event_action(type_of_user,id_input)
    end
  elsif event_action == "6"
    main_menu(type_of_user,id_input)
  elsif event_action == "7"
    initial_boot
  elsif event_action == "8"
    exit!
  else
    puts "Please select a valid option"
    event_action(type_of_user,id_input)
  end
end

def event_viewer(id_input)
  Event.view_events(id_input).map {|event|
    puts "Event ID: #{event[0]} #{event[1]} : #{event[2]}\nLowest Price: #{event[3]} Highest Price: #{event[4]}"
    puts "***********************************************************"
  }
end

def event_update_menu
  puts "***********************************************************"
  puts "1. Search for Events"
  puts "2. View my Events"
  puts "3. My Upcoming Event"
  puts "4. Delete an Event"
  puts "5. Cheapest event"
  puts "6. Back to main menu"
  puts "7. Log out"
  puts "8. Exit"
  puts "***********************************************************"
end
