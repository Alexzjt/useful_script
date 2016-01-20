require 'oj'
require 'mysql2'
require 'redis'
require 'date'
begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root")
  redis = Redis.new
  max_word_frequency_sort = 100000 #基本词频表，如果查询不到，则为最不常见单词，应比最大ID值还大
  unless redis.exists("notebook:one_hundred_thousand_word_frequency_lists")
    client.query("SELECT * FROM lab.one_hundred_thousand_word_frequency_lists").each do |item|
      redis.hset("notebook:one_hundred_thousand_word_frequency_lists", item["word"], item["id"])
    end
  end
  redis.del("notebook:reader_user_notebooks:all_users") if redis.exists("notebook:reader_user_notebooks:all_users")
  client.query("SELECT * FROM lab.reader_user_notebooks").each do |item|
    result_book_id = client.query("SELECT book FROM lab.reader_users where id=#{item["user_id"]} ")
    book_id = 1
    result_book_id.each do |xx|
      book_id = xx["book"]
    end
    book_name = ""
    result_book_name = client.query("SELECT book_name FROM lab.reader_books where id=#{book_id}")
    result_book_name.each do |xx|
      book_name=xx["book_name"]
    end
    unless redis.exists("notebook:#{book_id}:#{book_name}:word_frequency_statistics")
      client.query("SELECT list from lab.reader_page_words where book_id = #{book_id}").each do |list|
        #puts "#{list["list"]}"
        Oj.load(list["list"]).each do |word|
          if redis.hget("notebook:#{book_id}:#{book_name}:word_frequency_statistics", word).nil?
            redis.hset("notebook:#{book_id}:#{book_name}:word_frequency_statistics", word, 1)
          else
            temp_frequency = redis.hget("notebook:#{book_id}:#{book_name}:word_frequency_statistics", word).to_i
            redis.hset("notebook:#{book_id}:#{book_name}:word_frequency_statistics", word, temp_frequency+1)
          end
        end
      end
    end
    notebook_hash = Oj.load(item["list"])
    array1 = notebook_hash.keys #按时间排序
    array2 = notebook_hash.keys #按词频表词频排序
    array3 = notebook_hash.keys #按未来可能遇到的词排序
    array4 = notebook_hash.keys #最终排序
    array1.sort! do |a, b| #按时间排序
      if notebook_hash[a]>notebook_hash[b]
        -1
      elsif notebook_hash[a]==notebook_hash[b]
        0
      else
        1
      end
    end
    array2.sort! do |a, b| #按词频表词频排序
      sort_a = redis.hget("notebook:one_hundred_thousand_word_frequency_lists", a)
      sort_b = redis.hget("notebook:one_hundred_thousand_word_frequency_lists", b)
      sort_a = sort_a.nil? ? max_word_frequency_sort : sort_a.to_i
      sort_b = sort_b.nil? ? max_word_frequency_sort : sort_b.to_i
      if sort_a < sort_b
        -1
      elsif sort_a == sort_b
        0
      else
        1
      end
    end
    array3.sort! do |a, b| #按未来可能遇到的词排序
      frequency_a = redis.hget("notebook:#{book_id}:#{book_name}:word_frequency_statistics", a).to_i
      frequency_b = redis.hget("notebook:#{book_id}:#{book_name}:word_frequency_statistics", b).to_i
      if frequency_a>frequency_b
        -1
      elsif frequency_a==frequency_b
        0
      else
        1
      end
    end
    finally_word_sort_hash = Hash.new()
    array1.each do |word|
      finally_word_sort_hash[word] = array1.index(word)+array2.index(word)+array3.index(word)
    end
    array4.sort! do |a, b|
      if finally_word_sort_hash[a]<finally_word_sort_hash[b]
        -1
      elsif finally_word_sort_hash[a]==finally_word_sort_hash[b]
        0
      else
        1
      end
    end
    # puts "array1 = #{array1}"
    # puts "array2 = #{array2}"
    # puts "array3 = #{array3}"
    # puts "array4 = #{array4}"
    redis.hset("notebook:reader_user_notebooks:all_users", item["user_id"], array4.join("|"))
  end
  redis.del("notebook:one_hundred_thousand_word_frequency_lists")
  client.query("SELECT * FROM lab.reader_books").each do |item|
    redis.del("notebook:#{item["id"]}:#{item["book_name"]}:word_frequency_statistics")
  end
rescue
  puts "error"
ensure
  client.close
  redis.quit
end