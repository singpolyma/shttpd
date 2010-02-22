require 'cgi'

class Object
	def route
		@cgi = CGI.new
		self.send((ARGV[0] || 'main').intern)
	end
	# Proxy onto CGI
	def params
		@cgi.params.inject({}) do |hsh, i|
			if i[1].is_a?(Array) && i[1].length < 2
				hsh[i[0]] = i[1][0]
			else
				hsh[i[0]] = i[1]
			end
			hsh
		end
	end
	def method_missing(method, *args)
		@cgi.send(method, *args)
	end
end
