def get_responses(keyword_input)
  RestClient.get("http://app.ticketmaster.com/discovery/v2/events.json?keyword=#{keyword_input}&size=10&apikey=h6vI5u5dY3DSNEx4lZZ4OeGc9rXHQoqz")
end

def get_events_from_keyword(type_of_user, id_input)
  puts "To look for events, please provide a keyword to search. If you wish to return to the main menu, type in back"
  keyword_input = gets.chomp.capitalize
  if keyword_input == "Back"
    event_action(type_of_user,id_input)
  else
    response_string = get_responses(keyword_input)
    response_hash = JSON.parse(response_string)
    if response_hash["page"]["totalElements"] == 0
      puts "Sorry, we cannot find any events with the keyword '#{keyword_input}'. Please try something else."
      get_events_from_keyword(type_of_user, id_input)
    else
      event_list = get_event_names(response_hash)
      print_events(event_list)
      puts "Would you like to RSVP to one of the events above? Please enter the event row number (1-#{event_list.length}). If none of the events interest you please type 'No'"
      interest_input = gets.chomp.capitalize
      if interest_input == "No"
        event_action(type_of_user,id_input)
      elsif (1..event_list.length).to_a.include?(interest_input.to_i)
        event_name = event_list[interest_input.to_i-1][0]
        date = event_list[interest_input.to_i-1][1]
        min_price = event_list[interest_input.to_i-1][2]
        max_price = event_list[interest_input.to_i-1][3]
        add_event(event_name,type_of_user,id_input,date,min_price,max_price)
        event_action(type_of_user,id_input)
      else
        puts "Invalid response, returning to the main Event page."
        event_action(type_of_user,id_input)
      end
    end
  end
end

def get_event_names(response_hash)
  event_arr = []
  response_hash["_embedded"]["events"].map {|event_data|
    event_name = event_data["name"]
    event_date = event_data["dates"]["start"]["localDate"]
    binding.pry
    event_min_price = event_data["priceRanges"][0]["min"]
    event_max_price = event_data["priceRanges"][0]["max"]
    event_arr << [event_name,event_date,event_min_price,event_max_price]
    # binding.pry
   }
   event_arr
end

def print_events(event_arr)
  event_arr.each.with_index(1) {|event, index| puts "#{index}. #{event[0]} : #{event[1]} \n Min Ticket Price: #{event[2]} Max Ticket Price: #{event[3]}"; puts "------------------------------------------------------------------------"}
end

def add_event(event_name,type_of_user,id_input,date,min_price,max_price)
  # binding.pry
  if type_of_user == "1"
    Event.create(event_name: event_name,teacher_id: nil,student_id: id_input,date: date,purchase_date: Time.now)
  else
    Event.create(event_name: event_name,teacher_id: id_input,student_id: nil,date: date,purchase_date: Time.now)
  end
end

# binding.pry
# "hello"
