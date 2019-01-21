class Movie < ActiveRecord::Base
    
    require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document

doc = Nokogiri::HTML(open('https://movie.naver.com/movie/sdb/rank/rmovie.nhn'))

puts "### Search for nodes by css"
doc.css('nav ul.menu li a', 'article h2').each do |link|
  puts link.content
end

end