class Admin < ActiveRecord::Base
  has_many :students
  has_many :teachers

  def self.create_student(id)
    student = {first_name: nil, last_name: nil, module: nil, gender: nil,age: nil}
    puts "Enter Student first name: "
    student[:first_name] = gets.chomp.capitalize
    puts "Enter Student last name: "
    student[:last_name] = gets.chomp.capitalize
    puts "Enter Student module: "
    student[:module] = gets.chomp
    puts "Enter Student gender"
    student[:gender] = gets.chomp.capitalize
    puts "Enter Student age"
    student[:age] = gets.chomp
    if self.find_dupe_student(student[:first_name], student[:last_name], student[:module], student[:gender], student[:age])
      puts "Student already exists"
      return
    else
      Student.create(first_name: student[:first_name], last_name: student[:last_name], module: student[:module], gender: student[:gender],age: student[:age])
      puts "Student created"
    end
  end

  def self.create_teacher(id)
    teacher = {first_name: nil, last_name: nil, gender: nil,age: nil}
    puts "Enter Teacher first name: "
    teacher[:first_name] = gets.chomp.capitalize
    puts "Enter Teacher last name: "
    teacher[:last_name] = gets.chomp.capitalize
    puts "Enter Teacher gender"
    teacher[:gender] = gets.chomp.capitalize
    puts "Enter Teacher age"
    teacher[:age] = gets.chomp
    if self.find_dupe_teacher(teacher[:first_name], teacher[:last_name], teacher[:gender], teacher[:age])
      puts "Teacher already exists"
      return
    else
      Teacher.create(first_name: teacher[:first_name], last_name: teacher[:last_name], gender: teacher[:gender],age: teacher[:age])
      puts "Teacher created"
    end
  end

  def self.delete_student(student_id)
    puts "Enter Student id that you want to delete: "
    student = gets.chomp
    if self.find_student(student)
      Student.destroy(student)
      puts "Student deleted"
    else
      puts "Student doesn't exist"
      return
    end
  end

  def self.delete_teacher(teacher_id)
    puts "Enter Teacher id that you want to delete: "
    teacher = gets.chomp
    if self.find_teacher(teacher)
      Teacher.destroy(teacher)
      puts "Teacher deleted"
    else
      puts "Teacher doesn't exist"
      return
    end
  end

  def self.find_student(id)
    Student.find_by(id: id.to_i)
  end

  def self.find_teacher(id)
    Teacher.find_by(id: id.to_i)
  end

  def self.find_dupe_teacher(first_name, last_name, gender, age)
    Teacher.find_by(first_name: first_name, last_name: last_name, gender: gender, age: age)
  end

  def self.find_dupe_student(first_name, last_name, mod, gender, age)
    Student.find_by(first_name: first_name, last_name: last_name, module: mod, gender: gender, age: age)
  end

end
