require 'date'
require 'find'
origin = 5002
destination = 320
length= 186.88
date = 20141201
outfile = File.new("D:\\重庆数据\\实验结果\\按OD分析出行系数的结果从#{origin}到#{destination}.csv","w")
file_array = []
Find.find("D:\\重庆数据\\201412收费站出站数据") do |filename|
	file_array.push filename
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
		if array[28].to_i==0 && array[11].to_i<=1 && array[0].to_i==origin && array[9].to_i==destination
			between = (DateTime.parse(array[2])-DateTime.parse(array[10]))*1440   #1440==24*60
			next if between>1440   #如果在高速内停留时间超过一天，则判定为数据非法
			cxxs = between/length
			outfile.puts("#{date},#{line_counter},#{array[0]},#{array[9]},#{array[2]},#{array[10]},#{between.to_f},#{cxxs.to_f}")
		end
	end
	date+=1
	datefile.close
end
outfile.close