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
end
