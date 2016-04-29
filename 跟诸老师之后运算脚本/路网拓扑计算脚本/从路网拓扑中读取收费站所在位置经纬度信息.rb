roadlink_file=File.new("D:\\zjt\\路网拓扑zjt\\temp\\路链拓扑.csv")
output_file=File.new("D:\\zjt\\路网拓扑zjt\\temp\\含有收费站的路链拓扑.csv","w")
roadlink_file.each do |line|
	array=line.split(",")
	if(!array[15].eql?("null"))
		output_file.puts ("#{array[15]},#{array[0]},#{array[7]},#{array[8]}")
	end
end
roadlink_file.close
output_file.close
