#!/usr/bin/ruby -w

require "./toPPN"
require "./solveRPN"
require "./colorize"

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
print "Turn on Conflicts? (y/n)"
conf = gets.strip!
puts "Processing..."
file = IO.readlines(name)
vars = Array.new(26, 0)
qries = []
stmt = []
file.each do |str|
	str.strip!
	if str[0] === '#'

	elsif str[0] === '='
		i = 1
		while str[i]
			vars[str[i].ord - 'A'.ord] = 1
			i+=1
		end
	else
		if (str[0] === '?')
			i = 1
			while str[i]
				qries.push(str[i].ord - 'A'.ord)
				i+=1
			end
		elsif str != ""
			stmt.push(str)
		end
	end
end
RULE = Struct.new(:input_e, :out_e)
rules = []
stmt.each do |rle|
	arr = rle.split("<=>")
	if arr.length === 2
		con = arr[0].split("+")
		con.each do |conc|
			conc = conc.strip!
		end
		rpn = RPNExpression.from_infix arr[1]
		rules.push(RULE.new(rpn, con))
	else
		arr = rle.split("=>")
	end
	con = arr[1].split("+")
	con.each do |conc|
		conc = conc.strip!
	end
	rpn = RPNExpression.from_infix arr[0]
	rules.push(RULE.new(rpn, con))
end
change = 1
while change === 1
	change = 0
	confl = 0
	rules.each do |rule|
		rule["out_e"].each do |bb|
			tmp = solveRPN(rule["input_e"], vars)
			if (tmp === 1)
				if vars[bb[0].ord - 'A'.ord] === 0
					vars[bb[0].ord - 'A'.ord] = 1
					change = 1
				end
			else
				if (conf === "y" || conf === "Y") && vars[bb[0].ord - 'A'.ord] === 1
					confl = 1
				end
			end
		end
	end
end
if (confl === 1)
	abort("CONFLICT found")
end
qries.each do |qry|
	alpha = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
	if vars[qry] === 1
		puts "#{alpha[qry]} is TRUE".green
	else
		puts "#{alpha[qry]} is FALSE".red
	end
end