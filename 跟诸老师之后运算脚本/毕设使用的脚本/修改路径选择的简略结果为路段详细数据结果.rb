require 'find'
inpath = "D:\\实验结果BFS\\"
outpath = "D:\\路径选择详细版\\"
file_str_array = []
Find.find(inpath) do |file_str|
	file_str_array.push file_str if !File.directory?(file_str) && file_str.include?("csv")
end
file_str_array.each do |file_str|
	begin
		file = File.new(file_str,"w")
	rescue
		Dir.mkdir()
	end
end