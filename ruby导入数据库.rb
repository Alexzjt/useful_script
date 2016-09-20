# -*- coding:utf-8 -*- 
require 'mysql2'
client=nil
infile=nil
begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "19931110", :database => "shandong")
  infile=File.new("/home/zjt/File/全国收费站roadlink.csv");
  infile.each do |line|
    array=line.strip.split(",")
    sql="insert into shandong.stations values ('#{array[0]}','#{array[2]}',#{array[3]},#{array[4]},'#{array[5]}','#{array[6]}','#{array[7]}','#{array[1]}');"
    #puts sql
    client.query(sql)
  end
rescue
  #puts "error"
  puts $!
  puts $@
ensure
  client.close
  infile.close
end