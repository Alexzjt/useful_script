infile = File.new("D:\\重庆数据\\201412收费站出站数据\\20141201.csv")
outfile = File.new("D:\\重庆数据\\出口为0的记录.csv","w")
d = 0
infile.each do |line|
	array = line.split(",")
	outfile.puts line if array[9].to_i==0
end
infile.close
outfile.close