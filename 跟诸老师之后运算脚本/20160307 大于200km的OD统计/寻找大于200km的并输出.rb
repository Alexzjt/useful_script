infile = File.new("D:\\重庆数据\\梯形图格式转化.csv")
outfile = File.new("D:\\重庆数据\\收费站大于200km.csv","w")
infile.each do |line|
	array = line.split(",")
	outfile.puts line if array[2].to_i>=200
end
infile.close
outfile.close