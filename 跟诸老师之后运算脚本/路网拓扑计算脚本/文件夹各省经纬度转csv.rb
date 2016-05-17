# -*- coding: UTF-8 -*-
require 'find'
filename_array=[]
path="D:\\zjt\\29省收费站位置信息\\".encode('utf-8')
path1="D:\\zjt\\29省收费站位置信息转换后\\".encode('utf-8')
dir1=Dir.new(path)
dir1.each do |file_name|
	filename_array.push file_name.encode('utf-8')
end
dir1.close
filename_array.each do |file_name|
	if File.file?(path+file_name)
		name_array=file_name.split(".")
		file=File.new(path+file_name).tap{|f| f.set_encoding 'utf-8','GBK'}
		file2=File.new(path1+name_array[0]+".csv","w+")
		file.each do |line|
			line.encode('utf-8')
			array1=line.split("|")
		 	file2.puts "#{array1[0]},#{array1[1]}"
			#puts line
		end
		file.close
		file2.close
	end
end