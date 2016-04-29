newSP=File.new("E:\\百度云同步盘\\诸老师这边的事\\路网拓扑划分201604\\收费站最短距离.csv")
oldSP=File.new("E:\\百度云同步盘\\诸老师这边的事\\路网拓扑划分201604\\old收费站最短距离.csv")
outputSP=File.new("E:\\百度云同步盘\\诸老师这边的事\\路网拓扑划分201604\\收费站最短距离对比.csv","w")
hash=Hash.new()
oldSP.each do |line|
	array=line.split(",")
	hash["#{array[0]},#{array[1]}"]="#{array[2]},#{array[3]}"
end
newSP.each do |line|
	array=line.split(",")
	if(hash.include?("#{array[0]},#{array[1]}"))
		oldlength=hash["#{array[0]},#{array[1]}"]
		hash["#{array[0]},#{array[1]}"]="#{oldlength},#{array[2]}"
	else
		hash["#{array[0]},#{array[1]}"]=",,#{array[2]}"
	end
end
hash.each do |key,value|
	outputSP.puts "#{key},#{value}"
end
newSP.close
oldSP.close
outputSP.close