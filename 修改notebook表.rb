require 'oj'
require 'mysql2'
client = Mysql2::Client.new(:host => "localhost", :username => "root")
results = client.query("SELECT * FROM lab.reader_user_notebooks")
results.each do |item|
	arr = Oj.load(item["list"])
	result = Hash.new
	arr.each do |x|
        result[x] = Time.new.to_s
    end
    client.query("update lab.reader_user_notebooks set list = '#{Oj.dump(result)}' where id = #{item["id"]}")
end