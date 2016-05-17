require 'find'
file_array=[]
Find.find("D:\\zjt\\OD寻径结果（含次优）\\3503\\6005") do |file_name|
	file_array.push file_name
end
file=File.new("D:\\zjt\\OD寻径结果（含次优）\\3503\\6005\\186_21705.csv")
path=[]
file.each do |line|
	line_array=line.split(",")
	path.push line_array[0]
end
file.close
file_array.each do |file_name|
	unless  File.directory?(file_name)
	file=File.new(file_name)
		path_now=[]
		file.each do |line|
			line_array=line.split(",")
			path_now.push line_array[0]
		end
		file.close
		puts "#{(path_now-path).length}"
	end
end