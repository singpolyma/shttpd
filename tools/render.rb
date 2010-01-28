# Encode or decode complex data types as query strings
module QueryString; class << self
	require 'cgi' # For (un)escape

	# QueryString::encode(Hash or Enumerable) => String
	def encode(v, k=nil, raw_values=false)
		case v
			when Hash
				hash2query(v, k)
			when Enumerable
				array2query(v, k)
			else
				v = v.to_s
				(k ? k+'=' : '') + (raw_values ? v : CGI::escape(v))
		end
	end

	private

	def iencode(v,k=nil)
		CGI::escape(encode(v,k,true))
	end

	def hash2query(h,k=nil)
		l = k ? k+'[' : ''
		s = k ? ']' : ''
		h.keys.inject([]) { |c,ky|
			c << l+iencode(ky) + s + (h[ky] != nil ? '='+iencode(h[ky]) : '')
		}.join('&')
	end

	def array2query(v,k=nil)
		k = k ? k+'[]=' : ''
		k + v.inject([]) { |c,v|
			c << iencode(v)
		}.join('&' + k)
	end

end; end

class Object
	def render
		puts instance_variables.map { |var|
			QueryString::encode(instance_variable_get(var), var.to_s.sub(/^./,''))
		}.join('&')
	end
end

