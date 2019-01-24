# Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
# Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)

# NICE TO HAVES: STUDENTS: SEE PENDING/COMPLETED/FAILED ASSIGNMENTS, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY subject
# TEACHERS: SEE PENDING/COMPLETED/FAILED FOR CERTAIN STUDENTS/MODULE, UPCOMING ASSIGNMENT DUE, SEE ASSIGNMENT BY SUBJECT, SEE LATE ASSIGNMENTS,

# *****************************************************************************
# MAIN PAGE
# *****************************************************************************

def user_type
  puts "Welcome User, please identify yourself as: 1. Student, 2. Teacher, 3. Admin \n Put exit or quit to back out."
  input = gets.chomp
  if input == "1" || input == "2"
    input
  elsif input == "exit" || input == "quit"
    exit!
  elsif input == "3"
    puts "Please enter password: "
    password = gets.chomp
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
    puts "1. View Assignments"
    puts "2. Submit Assignments"
    puts "3. View Due Assignments (WIP)"
    puts "4. Events near me (WIP)"
    puts "5. Log off"
    puts "6. Exit"
  elsif input == "2"
    puts "1. View Assignments"
    puts "2. Add Assignments"
    puts "3. Update Assignment Info"
    puts "4. Delete Assignment"
    puts "5. Log off"
    puts "6. Exit"
  else
    puts "1. View Students"
    puts "2. Create Student"
    puts "3. Delete Student"
    puts "4. View Teachers"
    puts "5. Create Teacher"
    puts "6. Delete Teacher"
    puts "7. Log off"
    puts "8. Exit"
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
    Admin.delete_student(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "4"
    teachers_view(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "5"
    Admin.create_teacher(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "6"
    teachers_view(id_input)
    Admin.delete_teacher(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "7"
    initial_boot
  else
    exit!
  end
end

def students_view(input)
  Student.all.map {|student|
    puts "Student: ID: #{student.id} First Name: #{student.first_name} Last Name: #{student.last_name} Module: #{student.module}}"
    puts "***********************************************************"
  }
end

def teachers_view(input)
  Teacher.all.map {|teacher|
    puts "Teacher: ID: #{teacher.id} First Name: #{teacher.first_name} Last Name: #{teacher.last_name}}"
    puts "***********************************************************"
  }
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

def student_actions(action,id_input, type_of_user)
  if action == "1"
    student_view(id_input)
    main_menu(type_of_user, id_input)
  elsif action == "2"
    student_submission(type_of_user, id_input)
  elsif action == "5"
    initial_boot
  else
    exit!
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
    puts "Which lab do you wish to update?"
    assignment = gets.chomp.capitalize
    assignment_by_teacher = Teacher.find_assignment_by_teacher(id_input,assignment)
    if assignment_by_teacher
      teacher_update_info_menu(id_input,assignment,action,type_of_user)
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
  # Student table of content list of SEE ASSIGNMENTS (R), SUBMIT ASSIGNMENTS (U)
  # Teacher table of content list of ADD ASSIGNMENT (C), SEE ASSIGNMENTS (R), UPDATE STATUS (U), UPDATE ASSIGNMENT INFO, DELETE ASSIGNMENT (D)
  puts "1. Update title"
  puts "2. Update subject"
  puts "3. Update instructions"
  puts "4. Update start date"
  puts "5. Update due date"
  puts "6. Update status"
  puts "7. Update student id"
  puts "8. Back"
end
