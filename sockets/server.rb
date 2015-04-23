#server
require 'socket'
require 'json'

class HttpServer
	def initialize(client, request)
		@client = client
		@request = request
	end

	def parse_request
		@request_header, @request_body = @request.split("\r\n\r\n", 2)
		request_array = @request_header.split(' ')
		@method = request_array[0]
		@path = request_array[1]
	end

	def execute_request
		file = File.read(@path)
		if @method =~ /GET/
			@client.print("HTTP/1.0 200 OK\r\nDate: #{Time.now.ctime}\r\ntext/html\r\nContent-Length: #{file.size}\r\n\r\n")
			@client.puts(file)
		elsif @method =~ /POST/
			params = JSON.parse(@request_body)
			form_submission = "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>"
			@client.print("HTTP/1.0 200 OK\r\nDate: #{Time.now.ctime}\r\ntext/html\r\nContent-Length: #{file.size}\r\n\r\n")
			@client.puts(file.gsub("<%= yield %>", form_submission))
		else
			return_not_found
		end
	end

	def serve
		parse_request
		if File.exists?(@path)
			execute_request
		else
			return_not_found
		end
	end

	def return_not_found
		@client.puts("HTTP/1.0 404 Not Found")
	end
end

server = TCPServer.open(2000)
loop {
	Thread.start(server.accept) do |client|
		request = client.read_nonblock(512)
		http_server = HttpServer.new(client, request)
		http_server.serve
		client.close
	end
	
}