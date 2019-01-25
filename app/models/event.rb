class Event < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher

  def self.view_events(id)
    arr = []
    Event.where(student_id: id.to_i).each {|event|
      arr << [event.id,event.event_name,event.date]
    }
    arr
  end

  def self.recent_event(id)
    event_name = Event.where(student_id: id.to_i).order(:date).first.event_name
    event_date = Event.where(student_id: id.to_i).order(:date).first.date
    recent_event = [event_name,event_date]
    recent_event
  end

def self.delete_event(id)
  puts "Enter Event id that you want to delete: "
  event = gets.chomp
  binding.pry
  if self.find_event(event)
    Event.destroy(event)
    puts "Event deleted"
  else
    puts "Event doesn't exist"
    return
  end
end

def self.find_event(id)
  Event.find_by(id: id.to_i)
end

def self.cheapest_event(id)
  student = grab_student_events_not_nil(id)
  event_name = student.sort_by {|event| event[:min_ticket_price]}.first.event_name
  event_price = student.sort_by {|event| event[:min_ticket_price]}.first.min_ticket_price
  cheapest_event = [event_name,event_price]
  cheapest_event
end

def self.grab_student_events_not_nil(id)
  student = Student.find(id)
  student.events.select {|event| event.min_ticket_price != nil}
  end
end
