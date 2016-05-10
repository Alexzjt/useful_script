all=File.new("D:\\zjt\\路网拓扑zjt\\中间文件\\总高速编号.txt")
select=File.new("D:\\zjt\\路网拓扑zjt\\中间文件\\已标记高速编号.txt")
array_all=[]
array_select=[]
all.each do |line|
	if(!array_all.include?(line))
		array_all.push line
	end
end
select.each do |line|
	if(!array_select.include?(line))
		array_select.push line
	end
end
puts array_all-array_select
all.close
select.close