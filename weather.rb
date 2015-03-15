require 'yahoo_weatherman'

def get_location(zipcode)
    place = Weatherman::Client.new(:unit =>'f')
    place.lookup_by_location(zipcode)
end

puts "Please enter the zipcode of the 5 day forecast:"
weather = get_location(gets.chomp)

#Time.now is based on UTC time zone, not time zone of location. errors will occur if output is based on local time.
# ::local takes arguments not in time object format. need to create method. ::getlocal method does not exist in this ruby 2.1.5 version on Codio
today = Time.now.strftime('%w').to_i 

weather.forecasts.each do |forecast|
    day = forecast['date']
    weekday = day.strftime('%w').to_i
    
    #dayName of 'Today' and 'Tomorrow' may be inaccurate due to differences in UTC time zone from Time.now method
    if weekday == today
        dayName = "Today" 
        
        #accounts for when today is 6 (Saturday)
    elsif weekday == today+1 || weekday == today-6
        dayName = "Tomorrow"
    else 
        dayName = day.strftime('%A')
    end

    puts dayName + ' is going to be ' + forecast['text'].downcase + ' with a low of ' + forecast['low'].to_s+ ' and a high of ' + forecast['high'].to_s + ' degrees.'
end

# to be refactored