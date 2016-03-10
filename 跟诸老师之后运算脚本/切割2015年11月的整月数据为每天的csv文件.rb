require 'date'
infile  = File.new("E:\\重庆2015年11月刷卡数据\\11月高速出口刷卡数据.txt")
outpath = "E:\\重庆2015年11月刷卡数据\\11月高速出口刷卡数据分割\\"
date = Date.parse("2015-11-01")
end_date = Date.parse("2015-11-30")
file_hash = Hash.new()
while date<=end_date
	file_hash[date.to_s] = File.new(outpath+date.to_s+".csv","w")
	date += 1
end
############
infile.each do |line|
	array = line.split(";")
	begin
		file_hash[Date.parse(array[2]).to_s].puts line.gsub!(";",",")
	rescue Exception => e
		file_hash["2015-11-01"].puts line.gsub!(";",",")
	end
end
############
date = Date.parse("2015-11-01")
while date<=end_date
	file_hash[date.to_s].close
	date += 1
end