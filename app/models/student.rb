class Student < ActiveRecord::Base
  has_many :assignments
  has_many :teachers, through: :assignments
end
