require 'socket'
require 'json'

host = 'localhost'
port = 2000
puts "what type of http request? GET or POST"
req_type = gets.chomp.upcase

if req_type == "POST"
	puts "name:"
	name = gets.chomp
	puts "email:"
	email = gets.chomp
	path = "thanks.html"
	post_json = {:viking => {:name => name, :email => email}}.to_json
	
	request = "#{req_type} #{path} HTTP/1.0\r\nContent-Length: #{post_json.size}\r\n\r\n#{post_json}"
	puts request
elsif req_type == "GET"
	path = "index.html"
	request = "#{req_type} #{path} HTTP/1.0\r\n\r\n"
else
	puts "sorry I can't do #{req_type} method"
end

socket = TCPSocket.open(host, port)	#connect to the server
socket.print(request)
response = socket.read

headers,body = response.split("\r\n\r\n", 2)
puts "headers:"
puts headers
puts "\nbody"
puts body