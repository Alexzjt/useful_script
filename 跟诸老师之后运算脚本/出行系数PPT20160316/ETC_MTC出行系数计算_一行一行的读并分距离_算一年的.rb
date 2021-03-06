require 'date'
require 'find'
shangjie = 100
xiajie = 0
changdu = 5
date = Date.parse("20150101")
etc_cxxs_sum = []
mtc_cxxs_sum = []
etc_count = []
mtc_count = []
odfile = File.new("D:\\zjt\\重庆2015年11月刷卡数据\\梯形图格式转化.csv")
outfile = File.new("D:\\zjt\\实验结果\\20160317\\#{date.year}出行系数_#{xiajie}_#{shangjie}_#{changdu}_ETC_MTC.csv","w")
output_str = ""
jishuqi=0
temp = 0
while jishuqi<shangjie/changdu
	output_str+=",#{temp}_#{temp+changdu}_ETC,#{temp}_#{temp+changdu}_MTC"
	jishuqi+=1
	temp += changdu
end
outfile.puts output_str
file_array = []
Find.find("D:\\zjt\\实验结果\\20160317\\test\\") do |filename|
	file_array.push filename if !File.directory?(filename)
end
odhash = Hash.new(0)
odfile.each do |line|
	array = line.split(",")
	odhash[array[0]+"_"+array[1]]=array[2].to_f
end
file_array.each do |file|   
	puts file
	jishuqi=0
	while jishuqi<shangjie/changdu
		etc_cxxs_sum[jishuqi] = 0.0
		mtc_cxxs_sum[jishuqi] = 0.0
		etc_count[jishuqi] = 0
		mtc_count[jishuqi] = 0
		jishuqi+=1
	end
	datefile = File.new(file)
	datefile.each do |line|
		array = line.split(",")
		length = odhash[array[0]+"_"+array[9]]
		bianhao = length/changdu
		line_datetime = DateTime.parse(array[2])
		if array[28].to_i==0 && array[11].to_i<=1 && length>xiajie && length<shangjie && line_datetime.hour>=5 && line_datetime.hour<=20
			between = (line_datetime-DateTime.parse(array[10]))*86400  #1440==24*60
			next if between>86400   #如果在高速内停留时间超过一天，则判定为数据非法
			cxxs = between/length 
			if array[49].eql?("null") || array[49].gsub!(" ","").empty?   #这样写是因为2015年1到9月无ETC是“null”，10到12月是“        ”
				mtc_cxxs_sum[bianhao] += cxxs
				mtc_count[bianhao] += 1
			else
				etc_cxxs_sum[bianhao] += cxxs
				etc_count[bianhao] += 1
			end
		end
	end
	jishuqi=0
	output_str = "#{date.to_s}"
	while jishuqi<shangjie/changdu
		output_str+=",#{etc_cxxs_sum[jishuqi]/etc_count[jishuqi]},#{mtc_cxxs_sum[jishuqi]/mtc_count[jishuqi]}"
		jishuqi+=1
	end
	outfile.puts(output_str)
	date+=1
	datefile.close
end
odfile.close
outfile.close