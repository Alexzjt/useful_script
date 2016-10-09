# -*- coding:utf-8 -*- 
require 'mysql2'
client=nil
infile=nil
database_chart="shandong.stations_id_maps"
begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "19931110", :database => "shandong")
  infile=File.new("/media/zjt/ZJT/合并编号.csv")
  infile.each do |line|
    array=line.chomp.split(",")
    #puts "insert into #{database_chart} values ('#{array[0]}','#{array[1]}','#{array[2]}');"
    client.query("insert into #{database_chart} values ('#{array[0]}','#{array[1]}','#{array[2]}');")
  end
rescue
  #puts "error"
  puts $!
  puts $@
ensure
  client.close
  infile.close
end
