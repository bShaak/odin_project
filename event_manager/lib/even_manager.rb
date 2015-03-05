require "csv"
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(number)
	phone = number.to_s.scan(/\d+/).join
	if phone.length < 10
		phone = "0000000000"
	elsif phone.length == 10
		phone = phone
	elsif phone.length == 11
		phone = phone[1..10] if phone[0] == "1"
	end
	phone[0..2] + "-" + phone[3..5] + "-" + phone[6..9]
end

def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"

	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

def get_signup_hour(reg_date)
	date = DateTime.strptime(reg_date.to_s.gsub('/', '-'), '%m-%d-%Y %H:%M')
	date.hour
end

def get_signup_day(reg_date)
	date = DateTime.strptime(reg_date.to_s.gsub('/', '-'), '%m-%d-%Y %H:%M')
	date.wday
end

puts "Event manager initialized."

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

hours = Hash.new
days = Hash.new

contents.each do |row|
	id = row[0]
	name = row[:first_name]
	

	zipcode = clean_zipcode(row[:zipcode])

	legislators = legislators_by_zipcode(zipcode)

	phone = clean_phone_number(row[:homephone])
	#puts phone

	#puts row[:regdate].to_s
	date = row[:regdate]
	hour = get_signup_hour(date)
	day = get_signup_day(date)
	hours[hour].nil? ? hours[hour] = 1 : hours[hour] += 1
	days[day].nil? ? days[day] = 1 : days[day] += 1

	form_letter = erb_template.result(binding)

	#save_thank_you_letters(id, form_letter)
end

puts hours
puts days