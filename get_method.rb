=begin
PixivにGetリクエストを投げるためのクラス
=end
require 'net/http'

# GETリクエストを送るクラス
class GetRequest

	# 初期化するのにページの種類を指定する
	# 小文字でillustかmemberのどちらか
	def initialize(page_type)
		@request_url = "www.pixiv.net"
		@page_url = ""
		@param_value_pair = Hash::new
		@set_param_flag = false
		
		# PageTypeの内容からどのページにリクエストを送りたいのか判断する
		case page_type
		when "member"
			@page_url = "/member.php"
		when "illust"
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