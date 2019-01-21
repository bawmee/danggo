require ('nokogiri')
require ('open-uri')

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
     @posts =  Post.all.reverse #나중에 15로 
   
    
  end
  
  
  
  def bot

      @your = params[:talk]
      
      
      replyes = ['응', '아니야']
      @reply = replyes.sample(1)
      
      meals = ['떡볶이', '피자', '족발', '파스타', '짜장면', '돈까쓰', '초밥', '두리안']
      @meal = meals.sample(1)
      
      
      
      @queries=[]
      
      doc = Nokogiri::HTML(open('https://movie.naver.com/movie/sdb/rank/rmovie.nhn'))
      
      
      doc.css('.title .tit3' ).each do |r|
        rank = Hash.new
        rank['title'] = "#{r.css('a').text}"
        @queries << rank
      end
      
       @movie = @queries.sample(1)
       
       
        @queries2=[]
      
      doc = Nokogiri::HTML(open('https://www.twosome.co.kr:7009/menu/list.asp?rank=2'))
      
      doc.css('.des .tit').each do |r|
        ts = Hash.new
        ts['title'] = "#{r.css('font').text}"
        @queries2 << ts
      end
      
      @twosome = @queries2.sample(1)
      
      @queries3=[]
      
      doc = Nokogiri::HTML(open('http://paikdabang.com/menu/menu_coffee/'))
      
      doc.css('.hover').each do |r|
        ed = Hash.new
        ed['title'] = "#{r.css('h3').text}"
        @queries3 << ed
      end
      doc = Nokogiri::HTML(open('http://paikdabang.com/menu/menu_drink/'))
      
      doc.css('.hover').each do |r|
        ed = Hash.new
        ed['title'] = "#{r.css('h3').text}"
        @queries3 << ed
      end
      
      @bback = @queries3.sample(1)
    
  end
  
end
