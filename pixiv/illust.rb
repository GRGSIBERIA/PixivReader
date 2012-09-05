=begin
イラスト用クラスのファイル
=end
require './pixiv/member.rb'
require './WWW/get.rb'

# イラスト情報を格納するためのクラス
class Illust
	def initialize(illust_id)
		request = GetRequest.new("illust")
	
		# イラスト番号
		@illust_id = 0
		# タグの配列
		@tags = Array.new
		# 関連している百科事典ページ、タグ名=>URL
		@relative_dictionary = Hash.new
	end

end