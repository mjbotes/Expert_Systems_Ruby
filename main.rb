#!/usr/bin/ruby -w
puts "██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗           
██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗          
██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║          
██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║          
╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝          
 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝           
																							  
███████╗██╗  ██╗██████╗ ███████╗██████╗ ████████╗    ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗
██╔════╝╚██╗██╔╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝    ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║
█████╗   ╚███╔╝ ██████╔╝█████╗  ██████╔╝   ██║       ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║
██╔══╝   ██╔██╗ ██╔═══╝ ██╔══╝  ██╔══██╗   ██║       ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║
███████╗██╔╝ ██╗██║     ███████╗██║  ██║   ██║       ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║
╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝       ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝"
print "\n\nEnter file name: "
name = gets.strip!
puts "Processing..."
file = IO.readlines(name)
puts name
vars = Array.new(26, 0)
change = 0
qries = []
stmt = []
file.each do |str|
	str.strip!
	if str[0] === '#'
		str = ""
	elsif str[0] === '='
		i = 1
		while str[i]
			vars[str[i].ord - 'a'.ord] = 1
			i+=1
		end
	else
		if (str[0] === '?')
			i = 1
			while str[i]
				qries.push(str[i].ord - 'a'.ord)
				i+=1
			end
		elsif str != ""
			stmt.push(str)
		end
	end
end
Opp = Struct.new(:input_vars, :input_opp, :out_wars)
change = 1
e_opps = ["+", "|"]
while change === 1
	stmt.each do |jbrish|
		s_in_out = jbrish.split("=>")
		proce = s_in_out[0].strip!.split(' ')
		i_opp = []
		i_var = []
		proce.each do |oo|
			if e_opps.include?oo
				i_opp.push(oo)
			else
				i_var.push(oo.ord - 'a'.ord)
			end
		end
		proce = s_in_out[1].strip!.split(' ')
		o_opp = []
		o_var = []
		proce.each do |oo|
			if e_opps.include?oo
				i_opp.push(oo)
			else
				i_var.push(oo.ord - 'a'.ord)
			end
		end
		Test = Opp.new(i_var, i_opp, [])
	end
	change = 0
end
Test["input_vars"].each do |pr|
	puts pr
end
Test["input_opp"].each do |pr|
	puts pr
end