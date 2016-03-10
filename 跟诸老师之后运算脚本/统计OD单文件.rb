odhash = Hash.new(0)
infile = File.new("D:\\重庆数据\\201412收费站出站数据\\20141201.csv")
infile.each do |line|
	array = line.split(",")
	odhash[array[0]+"=>"+array[9]]+=1 if array[28].to_i==0 && array[11].to_i<=1
end
infile.close
outfile = File.new("D:\\重庆数据\\odcount_dan.txt","w")
outfile.puts "#{odhash}"
outfile.close