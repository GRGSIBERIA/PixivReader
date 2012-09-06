=begin
イラスト用クラスのファイル
=end
require './get_method.rb'
require './pixiv/html_source.rb'
require 'mechanize'
require 'kconv'
require 'rubygems'

# イラスト情報を格納するためのクラス
class Illust < HTMLSource
	def initialize(illust_id)
		request = GetRequest.new("illust")		# コンストラクタでイラストを指定
		request.SetParameter("mode", "medium")
		request.SetParameter("illust_id", illust_id)
		
		super(request.GetRequestURL())	# ここでMechanizeの初期化を行う
	
		@illust_id = illust_id
		@illust_title = GetTitle()
		@description = GetDescription()
		@tags = GetTags()
		
	end
	attr_reader :illust_id
	attr_reader :illust_title
	attr_reader :description
	attr_reader :tags
	attr_reader :member_name
	attr_reader :member_id
	
	# タイトルを取得してくる
	def GetTitle()
		path = 'h1[@class="title"]'
		return @agent.page.at(path).inner_text
	end
	
	# イラストの記事内容
	def GetDescription()
		path = 'div[@id="caption_long"]'
		return @agent.page.at(path).inner_text
	end
	
	def GetTags()
		#path = 'div[@id="tag_area"]'
		path = 'div[@class=pedia]'
		path += '//a'
		
		# 拾ってきたタグの中から関連ページを排除する
		all_tags = @agent.page.search(path)
		tags = Array.new
		for i in 0..all_tags.length-1
			all_tags[i].each{|k,v| 
				if v.include?("tags.php") then # tags.phpから該当するタグを抜き出す
					tags << all_tags[i].inner_text 
				end
			}
		end
		for i in 0..tags.length-1
			puts tags[i]
		end
		return tags
	end
end

