require 'date'
infile  = File.new("E:\\重庆2015年5月6月7月\\测速仪5-7月.txt")
outpath = "E:\\重庆2015年5月6月7月\\"
date = Date.parse("2015-05-01")
end_date = Date.parse("2015-07-31")
file_hash = Hash.new()
while date<=end_date
	begin
		file_hash[date.to_s] = File.new(outpath+date.year.to_s+"_"+date.month.to_s+"\\"+date.to_s+".csv","w")
	rescue
		Dir.mkdir(outpath+date.year.to_s+"_"+date.month.to_s+"\\")
		file_hash[date.to_s] = File.new(outpath+date.year.to_s+"_"+date.month.to_s+"\\"+date.to_s+".csv","w")
	ensure
		date += 1
	end
end
############
infile.each do |line|
	array = line.split(",")
	begin
		file_hash[Date.parse(array[6]).to_s].puts line
	rescue Exception => e
		#file_hash["2015-11-01"].puts line
	end
end
############
date = Date.parse("2015-05-01")
while date<=end_date
	file_hash[date.to_s].close
	date += 1
end