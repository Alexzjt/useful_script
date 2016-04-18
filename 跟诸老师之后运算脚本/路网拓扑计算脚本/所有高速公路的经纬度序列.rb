mid_file=File.new("D:\\zjt\\重庆地图\\Rchongqing.mid")
mif_file=File.new("D:\\zjt\\重庆地图\\Rchongqing.mif")
highway_lonlat=File.new("D:\\zjt\\路网拓扑zjt\\highway_lonlat.csv","w+")
kind_txt=File.new("D:\\zjt\\路网拓扑zjt\\kind.txt","w+")
mid_line=1
mif_kuai=0
highway_line=[]
mid_file.each do |line|
	line_array=line.split(",")
	kind_array=line_array[3].split("")
	if(kind_array[1].eql?("0")&&kind_array[2]==("0"))
		highway_line.push mid_line
		kind_txt.puts(line_array[3])
	end
	mid_line+=1
end
lonlat_array=[]
mif_file.each do |line|
	if(line.include?("Line")||line.include?("Pline"))
		mif_kuai+=1
		lonlat_array=[]
		lonlat_array.push line
	elsif (line.include?("Pen"))
		if(highway_line.include?(mif_kuai))
			#puts mif_kuai
			count=0
			lon=""
			lat=""
			lonlat_array.each do |x|
				array_x=x.split(" ")
				array_x.each do |str|
					if(str.include?("."))
						count+=1
						if(count%2!=0)
							lon=str
						else
							lat=str
							highway_lonlat.puts("#{lon},#{lat}")
						end
					end
				end
			end
		else
			next
		end
	else
		lonlat_array.push line
	end
end
highway_lonlat.close
mid_file.close
mif_file.close
kind_txt.close