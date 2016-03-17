require 'find'
infile_road = File.new("D:\\重庆数据\\20150616新地图\\路网拓扑0629.csv")
inpath = "D:\\实验结果BFS\\"
outpath = "D:\\路径选择详细版\\"
#############读路段文档############
road_hash = Hash.new()
infile_road.each do |line|
	array = line.split(",")
	road_hash[array[0]]=line
end
infile_road.close
##############################
file_str_array = []
Find.find(inpath) do |file_str|
	file_str_array.push file_str if !File.directory?(file_str) && file_str.include?("csv")
end
file_str_array.each do |file_str|
	begin
		file = File.new(file_str,"w")
		file.each do |line|
			array = line.split(",")
			
		end
	rescue
		puts "异常！  #{file_str}"
	ensure
		file.close
	end
end