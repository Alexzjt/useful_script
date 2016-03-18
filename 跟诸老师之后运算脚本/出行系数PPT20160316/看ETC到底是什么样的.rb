infile = File.new("D:\\zjt\\2015年数据\\201510\\2015-10-31.csv")
odfile = File.new("D:\\zjt\\重庆2015年11月刷卡数据\\梯形图格式转化.csv")
odhash = Hash.new(0)
odfile.each do |line|
	array = line.split(",")
	odhash[array[0]+"_"+array[1]]=array[2].to_f
end
infile.each do |line|
	array = line.split(",")
	length = odhash[array[0]+"_"+array[9]]
	puts "#{array[0]} #{array[9]} #{array[49]}" if !array[49].strip.empty? && length>=2 && length<=5
end
infile.close