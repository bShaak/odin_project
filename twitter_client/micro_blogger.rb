require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing MicroBlogger"
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		@client.update(message) unless message.length > 140
	end

	def followers_list
		screen_names = []
		@client.followers.each {|f| screen_names << @client.user(f).screen_name}
		return screen_names
	end

	def spam_my_followers(message)
		followers = followers_list
		followers.each { |f| dm(f, message)}
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message"
		puts message
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name}
		message = "d @#{target} #{message}"
		if screen_names.include?(target)
			tweet(message) 
		else
			puts "You can only dm people that follow you"
		end
	end

	def shorten(original_url)
		Bitly.use_api_version_3
		puts "Shortening this url: #{original_url}"
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		return bitly.shorten(original_url).short_url
	end

	def everyones_last_tweet
		friends = @client.friends.to_a
		friends.sort_by! {|friend| @client.user(friend).screen_name.downcase}
		friends.each do |friend|
			#find friend's last message
			puts @client.user(friend).screen_name
			#print last message
			puts @client.user(friend).status.text
			puts @client.user(friend).status.created_at.strftime("%A, %b, %d")
			#puts friend.status.text
			puts ""
		end
	end

	def run
		puts "welcome"
		command = ""
		while command != "q"
			puts "enter command: "
			parts = gets.chomp.split(" ")
			command = parts[0]

			case command
			when 'q' then puts "Goodbye"
			when 't' then tweet(parts[1..-1].join(" "))
			when 'dm' then dm(parts[1], parts[2..-1].join(" "))
			when 'spam' then spam_my_followers(parts[1..-1].join(" "))
			when 'elt' then everyones_last_tweet
			when 's' then shorten(parts[1])
			when 'turl' then tweet(parts[1..-2] + " " + shorten(parts[-1]))
			else
				puts "Sorry I don't know how to #{command}"
			end
		end
	end
end

blogger = MicroBlogger.new
blogger.run