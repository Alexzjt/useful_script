require 'date'
require 'find'
upbound = 450
downbound = 400
date = 20151101
odfile = File.new("D:\\重庆数据\\梯形图格式转化.csv")
#datefile = File.new("D:\\重庆数据\\201412收费站出站数据\\20141201.csv")
outfile = File.new("E:\\重庆2015年11月刷卡数据\\实验结果\\2015年11月按天分析出行系数的结果#{downbound}_#{upbound}.csv","w")
file_array = []
Find.find("E:\\重庆2015年11月刷卡数据\\11月高速出口刷卡数据分割") do |filename|
	file_array.push filename
end
odhash = Hash.new(0)
odfile.each do |line|
	array = line.split(",")
	odhash[array[0]+"_"+array[1]]=array[2].to_f
end
file_array.each do |file|
	next if File.directory? (file)
	puts file
	sum_cxxs = 0
	counter = 0
	line_counter = 0
	datefile = File.new(file)
	datefile.each do |line|
		line_counter+=1
		array = line.split(",")
		length = odhash[array[0]+"_"+array[9]]
		if array[28].to_i==0 && array[11].to_i<=1 && length>=downbound && length<=upbound 
			between = (DateTime.parse(array[2])-DateTime.parse(array[10]))*1440   #1440==24*60
			next if between>1440   #如果在高速内停留时间超过一天，则判定为数据非法
			cxxs = between/length 
			sum_cxxs += cxxs
			counter+=1
		end
	end
	outfile.puts("#{date},#{sum_cxxs/counter}")
	date+=1
	datefile.close
end
odfile.close
outfile.close