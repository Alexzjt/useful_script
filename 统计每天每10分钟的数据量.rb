require 'date'
#class Record
#	attr_accessor :ExTime,:ExStation,:VC,:EnStation,:EnTime,:LastMoney
#end
dateHash = Hash.new(0)
infile = File.new("E:\\lab\\MTC出口20151101-20160128.txt")
infile.each do |line|
	array = line.split(",")
	array1 = array[1].split("")
	minute = ((array1[12].to_i*10+array1[13].to_i)*60+array1[15].to_i*10)/10*10
	dateHash[Date.parse(array[1]).to_s+"=>"+minute.to_s] += 1
end
outfile = File.new("E:\\lab\\10min_MTC_datecount.txt","w")
outfile.puts "#{dateHash}"
infile.close
outfile.close