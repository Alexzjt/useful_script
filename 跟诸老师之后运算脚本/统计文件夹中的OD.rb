require "find"
file_array = []
Find.find("D:\\重庆数据\\201412收费站出站数据") do |filename|
	file_array.push filename
end
odhash = Hash.new(0)
file_array.each do |file|
	unless File.directory? (file)
		infile = File.new(file)
		infile.each do |line|
			array = line.split(",")
			odhash[array[0]+"=>"+array[9]]+=1 if array[28].to_i==0 && array[11].to_i<=1
		end
		infile.close
	end
end
outfile = File.new("D:\\重庆数据\\odcount_201412.txt","w")
outfile.puts "#{odhash}"
outfile.close