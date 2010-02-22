require 'json'

class Object
	def render(*args)
		puts instance_variables.inject(
			{:args => args.inject({}) do |h,i|
					if i.is_a?Hash
						h.merge!(i)
					else
						h[args.index(i)] = i
					end
				end }
		) { |hsh, var|
			hsh[var.to_s.sub(/^./,'')] = instance_variable_get(var)
			hsh
		}.to_json
	end
end

