x = Dir.new("D:\\实验结果BFS")
dir_array = []
x.each do |y|
	dir_array.push y if !y.eql?(".") && !y.eql?("..")
end
outpath = "D:\\路径选择详细版\\"
i=0
while i<dir_array.length
	temp_path = outpath+dir_array[i]+"\\"
	Dir.mkdir(temp_path)
	j=0
	while j<dir_array.length
		Dir.mkdir(temp_path+dir_array[j]+"\\")
		j+=1
	end
	i+=1
end