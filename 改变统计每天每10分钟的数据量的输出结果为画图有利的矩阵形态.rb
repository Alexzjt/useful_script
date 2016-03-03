require 'date'
start_date = Date.parse("2015-11-01")
end_date = Date.parse("2016-01-19")
infile = File.new("10min_ETC_datecount.csv")
store_hash = Hash.new(0)
infile.each do |line|
	array=line.split(",")
	store_hash[Date.parse(array[0]).to_s+"_"+array[1]]=array[2].to_i
end
outfile = File.new("10min_ETC_datecount_to_matrix.csv","w")
temp_date = start_date
str=""
while temp_date<=end_date
	str += ","+temp_date.to_s
	temp_date+=1
end
outfile.puts(str)
minute=0
while(minute<1440)
	temp_str = minute.to_s
	temp_date = start_date
	while temp_date<=end_date
		#print store_hash[temp_date.to_s+"_"+minute.to_s].to_s
		temp_str+=","+store_hash[temp_date.to_s+"_"+minute.to_s].to_s
		temp_date+=1
	end
	outfile.puts(temp_str)
	minute+=10
end
infile.close
outfile.close