str = "gallery architect musician dollar gold candle exchange sleep prince glove sunshine butterfly wallet withdraw winner firework earthquake consumer president typhoon vacation marriage birthday giraffe actor"
arr = str.split(" ")
id = 6
arr.each do |item|
	puts "insert into bigbang.voc_builder_word_lists values(#{id},'#{item}',#{(id-1)/5+1},now(),now());"	
	id += 1
end
