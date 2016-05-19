dir=Dir.new("D:\\zjt\\四维图新\\level2\\level2")
dir.each do |path|
	if(path.eql?(".")||path.eql?(".."))
		next
	end
province=path
file_mid=File.new("D:\\zjt\\四维图新\\level2\\level2\\#{province}\\road\\C#{province}.mid")
file_mif=File.new("D:\\zjt\\四维图新\\level2\\level2\\#{province}\\road\\C#{province}.mif")
file_output=File.new("D:\\zjt\\四维图新\\收费站点所在经纬度分省\\#{province}.csv","w+")
station_lines_array=[]
line_station_hash={}
count=1
file_mid.each do |line|
	line_array=line.split("\",\"")
	if(line_array[5].eql?("3"))
		station_lines_array.push count
		line_station_hash[count]=line_array[2]
	end
	count+=1
end
count=1
file_mif.each do |line|
	if(line.include?("Point"))
		if(station_lines_array.include?(count))
			station_lines_array.delete(count)
			line_array=line.split(" ")
			str=line_station_hash[count]
			file_output.puts "#{str},#{line_array[1]},#{line_array[2]}"
		end
		count+=1
	end
end
file_output.close
file_mid.close
file_mif.close
end
dir.close