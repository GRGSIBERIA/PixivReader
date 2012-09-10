=begin
Mechanizeでソースを引っ張ってくるベースクラス
=end
require 'mechanize'


module Pixiv
	# MechanizeでHTMLのソースコードを取得するクラス
	class HTMLSource
		# URLからGETリクエストを送り、ソースコードを取得する
		def initialize(url)
			@agent = Mechanize.new
			@agent.get(url)
		end
	end
end