require 'date'
require 'find'
upbound_array = [50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800]
downbound_array = [2,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750]
bound_counter = 0
while bound_counter<upbound_array.length
	upbound=upbound_array[bound_counter]
	downbound=downbound_array[bound_counter]
date = 20151101
odfile = File.new("D:\\重庆数据\\梯形图格式转化.csv")
#datefile = File.new("D:\\重庆数据\\201412收费站出站数据\\20141201.csv")
outfile = File.new("E:\\重庆2015年11月刷卡数据\\实验结果\\ETCMTC\\2015年11月按天分析出行系数的结果#{downbound}_#{upbound}_ETC_MTC.csv","w")
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
	puts file+"#{upbound}"+"#{downbound}"
	sum_cxxs_ETC = 0
	sum_cxxs_MTC = 0
	counter_ETC = 0
	counter_MTC = 0
	line_counter = 0
	datefile = File.new(file)
	datefile.each do |line|
		line_counter+=1
		array = line.split(",")
		length = odhash[array[0]+"_"+array[9]]
		line_datetime = DateTime.parse(array[2])
		if array[28].to_i==0 && array[11].to_i<=1 && length>=downbound && length<=upbound && line_datetime.hour>=5 && line_datetime.hour<=20
			between = (line_datetime-DateTime.parse(array[10]))*86400  #1440==24*60
			next if between>86400   #如果在高速内停留时间超过一天，则判定为数据非法
			cxxs = between/length 
			if array[49].gsub!(" ","").empty?
				sum_cxxs_MTC += cxxs
				counter_MTC+=1
			else
				sum_cxxs_ETC += cxxs
				counter_ETC+=1
			end
		end
	end
	outfile.puts("#{date},#{sum_cxxs_ETC/counter_ETC},#{sum_cxxs_MTC/counter_MTC}")
	date+=1
	datefile.close
end
odfile.close
outfile.close
bound_counter+=1
end