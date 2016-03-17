infile = File.new("D:\\zjt\\2015年数据\\201510\\2015-10-01.csv")
infile.each do |line|
	array = line.split(",")
	puts "#{array[49]}"
end
infile.close