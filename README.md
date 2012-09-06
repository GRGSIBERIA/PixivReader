PixivReader
===========

Pixivのイラスト情報をログインなしで取得するための簡易ライブラリです。
使い方は簡単で、

===========================
require './pixiv/pixiv_illust.rb'

illust = Illust.new(画像のID)
===========================

で取得することができます。
ログインした場合と比べて読み込める内容に制限はありますが、
画像IDからタグやイラストのタイトル、制作者を調べたいだけの時には
短いコードで簡単に利用することができます。


===ドキュメント===

Illustクラス
	イラストの情報が格納されるクラスです。
	
	===Method===
	def initialize(illust_id)
		画像IDを指定してPixivから情報を取得してきます
		illust_id :: イラストの情報を取得したい画像ID
		
	===AttrReader===
	illust_id :: String
		イラストの画像IDです。
		
	illust_title :: String
		イラストのタイトルです。
		
	caption :: String
		イラストの見出し文です。
		
	tags :: Array.String
		イラストのタグです。配列になっています。
	
	member_id :: String
		投稿者のPixivメンバーIDです。
	
	member_name :: String
		投稿者の名前です。