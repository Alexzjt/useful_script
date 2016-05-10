newSP=File.new("E:\\百度云同步盘\\诸老师这边的事\\路网拓扑划分201604\\收费站最短距离20160504175825.csv")
oldSP=File.new("E:\\百度云同步盘\\诸老师这边的事\\路网拓扑划分201604\\old收费站最短距离.csv")
outputSP=File.new("E:\\百度云同步盘\\诸老师这边的事\\路网拓扑划分201604\\收费站最短距离对比.csv","w")
od_qingfen=Hash.new()
od_old_sp=Hash.new()
od_new_sp=Hash.new()
oldSP.each do |line|
	array=line.split(",")
	od_qingfen["#{array[0]},#{array[1]}"]=array[2].chomp
	od_old_sp["#{array[0]},#{array[1]}"]=array[3].chomp
end
newSP.each do |line|
	array=line.split(",")
	od_new_sp["#{array[0]},#{array[1]}"]=array[2].chomp
end
od_new_sp.each do |key,value|
	outputSP.puts "#{key},#{od_qingfen[key]},#{od_old_sp[key]},#{od_new_sp[key]},#{od_new_sp[key].to_f/od_qingfen[key].to_f},#{od_new_sp[key].to_f/od_old_sp[key].to_f}"
end
newSP.close
oldSP.close
outputSP.close