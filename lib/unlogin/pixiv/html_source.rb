=begin
Mechanize�Ń\�[�X�����������Ă���x�[�X�N���X
=end
require 'mechanize'


module Pixiv
	# Mechanize��HTML�̃\�[�X�R�[�h���擾����N���X
	class HTMLSource
		# URL����GET���N�G�X�g�𑗂�A�\�[�X�R�[�h���擾����
		def initialize(url)
			@agent = Mechanize.new
			@agent.get(url)
		end
	end
end