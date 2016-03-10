require 'date'
upbound = 200
downbound = 150
odfile = File.new("D:\\重庆数据\\梯形图格式转化.csv")
datefile = File.new("D:\\重庆数据\\201412收费站出站数据\\20141202.csv")
#outfile = File.new("D:\\重庆数据\\20141201分析出行系数的结果1.csv","w")
odhash = Hash.new(0)
odfile.each do |line|
	array = line.split(",")
	odhash[array[0]+"_"+array[1]]=array[2].to_f
end
sum_cxxs = 0
counter = 0
line_counter = 0
datefile.each do |line|
	line_counter+=1
	array = line.split(",")
	length = odhash[array[0]+"_"+array[9]]
	if array[28].to_i==0 && array[11].to_i<=1 && length>=downbound && length<=upbound 
		between = (DateTime.parse(array[2])-DateTime.parse(array[10]))*1440   #1440==24*60
		break if between>1440   #如果在高速内停留时间超过一天，则判定为数据非法
		cxxs = between/length 
		sum_cxxs += cxxs
		counter+=1
		#outfile.puts("#{line_counter},#{sum_cxxs},#{cxxs},#{between},#{length},#{array[2]},#{array[10]}")
	end
end
puts sum_cxxs/counter
odfile.close
datefile.close
#outfile.close