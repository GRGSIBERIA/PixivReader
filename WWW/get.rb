=begin
PixivにGetリクエストを投げるためのクラス
=end
require 'net/http'
require './WWW/page_type.rb'

# GETリクエストを送るクラス
class GetRequest

	# 初期化するのにページの種類を指定する
	# PageTypeクラスの定数を使うのを推奨
	def initialize(page_type)
		@request_url = "www.pixiv.net"
		@page_url = ""
		@param_value_pair = Hash::new
		@set_param_flag = false
		
		# PageTypeの内容からどのページにリクエストを送りたいのか判断する
		case page_type
		when PageType::MEMBER
			@page_url = "/member.php"
		when PageType::MEMBER_ILLUST
			@page_url = "/member_illust.php"
		end
	end
	
	# GETで送るパラメータと値を指定する
	def SetParameter(parameter, value)
		if @set_param_flag == false then
			@page_url += "?"
		else
			@page_url += "&" 
		end
		@page_url += parameter.to_s +  "=" + value.to_s
	end
	
	# GETでリクエストを送信し、その結果を取得する
	def SendRequest()	
		# URLを展開してGETでアクセス、responseに結果を入れる
		request = Net::HTTP::Get.new(@page_url)
		response = Net::HTTP.start(@request_url, 80) {|http|
			http.request(request)
		}
		return response.body	# 本文のみを返す
	end
end

request = GetRequest.new(PageType::MEMBER)
request.SetParameter("id", 32777)

open("test.txt", "w") {|f| f.write request.SendRequest()}