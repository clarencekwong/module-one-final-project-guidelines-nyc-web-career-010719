class Event < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher

  def self.view_events(id)
    arr = []
    Event.where(student_id: id.to_i).each {|event|
      arr << [event.event_name,event.date]
    }
    arr
  end

  def self.recent_event(id)
    event_name = Event.where(student_id: id.to_i).order(:date).first.event_name
    event_date = Event.where(student_id: id.to_i).order(:date).first.date
    recent_event = [event_name,event_date]
    recent_event
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
