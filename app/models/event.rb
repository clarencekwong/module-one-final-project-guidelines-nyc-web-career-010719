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

end
