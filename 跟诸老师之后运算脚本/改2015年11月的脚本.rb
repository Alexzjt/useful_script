require 'date'
infile = File.new("E:\\重庆2015年11月刷卡数据\\11月高速出口刷卡数据分割\\2015-11-01.txt")
outfile = File.new("E:\\重庆2015年11月刷卡数据\\11月高速出口刷卡数据分割\\2015-11-01.csv","w")
infile.each do |line|
	array = line.split(",")
	begin
		DateTime.parse(array[2])
		outfile.puts line
	rescue

	end
end
infile.close
outfile.close