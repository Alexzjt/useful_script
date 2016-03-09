odhash = Hash.new(0)
infile = File.new("11月高速出口刷卡数据.txt")
infile.each do |line|
	array = line.split(";")
	odhash[array[0]+"=>"+array[9]]+=1 if array[28].to_i==0 && array[11].to_i<=1
end
outfile = File.new("odcount0.txt","w")
outfile.puts "#{odhash}"
infile.close
outfile.close