# -*- coding:utf-8 -*- 
require 'mysql2'
require 'find'
load "myFunction.rb"
client=nil
infile=nil
boolean=[true,true,false,true]
database_chart="shandong.shortest_paths"
begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "19931110", :database => "shandong")
  
  	Find.find("/media/zjt/Ubuntu\ 16.0/文件夹") do |path|
  next if File.directory?(path)
  begin
  infile=File.new(path)
  puts File::basename(infile)
  
  number=1
  buffer=""
  infile.each do |line|
  	string=MYFUNCTION::append(line,boolean)
  	if(number%1000==0)
  		buffer+=string
  		sql="insert into #{database_chart} (origin,destination,length,path) values #{buffer};"
  		client.query(sql)
  		buffer=""
  		#puts number
  	else
  		buffer+=string+","
  	end
    #puts sql
    number+=1
  end
  sql="insert into #{database_chart} (origin,destination,length,path) values #{buffer.chop};"
  client.query(sql)
  rescue
  puts $!
  puts $@
  ensure
  infile.close
  end
end
  
rescue
  #puts "error"
  puts $!
  puts $@
ensure
  client.close
  
end
