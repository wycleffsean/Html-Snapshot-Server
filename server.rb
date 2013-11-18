require 'webrick'
include WEBrick

class Simple < HTTPServlet::AbstractServlet
	def do_GET request, response
		uri = request.unparsed_uri
		#p uri
		response['Content-Type'] = request.content_type
		response.body = `phantomjs script.js "http://localhost:3000#{uri}"`
		raise HTTPStatus::OK
	end

	alias_method :do_POST, :do_GET
end

def start_server(config = {})
	config.update(Port:2000)
	server = HTTPServer.new(config)
	yield server if block_given?
	['INT', 'TERM'].each {|signal| trap(signal) { server.shutdown }} # handle termination
	server.start
end

start_server do |server|
	server.mount '/', Simple
end


