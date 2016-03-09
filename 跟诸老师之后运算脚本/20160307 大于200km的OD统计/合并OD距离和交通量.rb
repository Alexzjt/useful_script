infile1 = File.new("odcount0transfer.txt")
infile2 = File.new("梯形图格式转化.csv")
outfile = File.new("OD距离交通量.txt","w")
odhash = Hash.new(0)
infile2.each do |line|
	array = line.split(",")
	odhash[array[0]+"=>"+array[1]]=array[2].to_i
end
infile1.each do |line|
	array = line.split(",")
	key = array[0]+"=>"+array[1]
	value = odhash[key]
	odhash[key] = value.to_s + "=>" + array[2].to_i.to_s
end
outfile.puts "#{odhash}"
infile1.close
infile2.close
outfile.close
