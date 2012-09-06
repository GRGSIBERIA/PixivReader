﻿=begin
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
		@member_id = GetMemberID()
		@member_name = GetMemberName()
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
	
	# タグを取得
	def GetTags()
		#path = 'div[@id="tag_area"]'
		path = 'div[@class=pedia]'
		path += '//a'
		
		# 拾ってきたタグの中から関連ページを排除する
		all_tags = @agent.page.search(path)
		tags = Array.new
		for i in 0..all_tags.length-1
			all_tags[i].each{|k,v| 
				if v.include?("tags.php") then # tags.php以外のタグは排除
					tags << all_tags[i].inner_text 
				end
			}
		end
		return tags
	end
	
	# 投稿者のPixivメンバーIDの取得
	def GetMemberID()
		path = 'h2/a'
		link = @agent.page.search(path)
		member_id = ""
		for i in 0..link.length-1
			if link[i]['href'].include?('member.php?') then
				member_id = link[i]['href']
				break
			end
		end
		return member_id.sub!("member.php?id=", "")
	end
	
	# Pixivメンバーの名前を取得する
	def GetMemberName()
		path = 'h2/a/img'
		link = @agent.page.search(path)
		member_name = ""
		for i in 0..link.length-1
			# imgタグの中に
			if link[i]['title'] != nil then
				member_name = link[i]['title']
				break
			end
		end
		return member_name
	end
end

