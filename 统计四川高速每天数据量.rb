require 'date'
#class Record
#	attr_accessor :ExTime,:ExStation,:VC,:EnStation,:EnTime,:LastMoney
#end
dateHash = Hash.new(0)
infile = File.new("E:\\lab\\MTC出口20151101-20160128.txt")
infile.each do |line|
	array = line.split(",")
	dateHash[Date.parse(array[1]).to_s] += 1
end
outfile = File.new("E:\\lab\\datecount.txt","w")
outfile.puts "#{dateHash}"
infile.close
outfile.close