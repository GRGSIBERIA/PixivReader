=begin
HTMLのソースコードを格納するための基底クラスのファイル
=end
require 'mechanize'

# MechanizeでHTMLのソースコードを取得するクラス
class HTMLSource
	# URLからGETリクエストを送り、ソースコードを取得する
	def initialize(url)
		@agent = Mechanize.new
		@agent.get(url)
	end
end