# -*- coding:utf-8 -*- 
require 'mysql2'
require 'find'
client=nil
infile=nil
begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "19931110", :database => "shandong")
  Find.find("/media/zjt/Ubuntu\ 16.0/29省路网拓扑合并版增加省名称") do |path|
  next if File.directory?(path)
  infile=File.new(path);
  number=1
  buffer=""
  infile.each do |line|
  	sql="insert into shandong.roadlinks values #{line};"
  	puts sql
  	client.query(sql)
  end
  infile.close
  end
rescue
  #puts "error"
  puts $!
  puts $@
ensure
  client.close
  
end
