require './pixiv/html_source.rb'

module Pixiv
	# �C���X�g�����i�[���邽�߂̃N���X
	class Illust < HTMLSource
		def initialize(illust_id)
			request = GetRequest.new("illust")		# �R���X�g���N�^�ŃC���X�g���w��
			request.SetParameter("mode", "medium")
			request.SetParameter("illust_id", illust_id)
			
			super(request.GetRequestURL())	# ������Mechanize�̏��������s��
		
			if !@agent.page.at('span[@class="error"]') then
				raise IllustNotFoundError, illust_id.to_s + " is not found."
			end
		
			@illust_id = illust_id
			@title = GetTitle()
			@caption = GetCaption()
			@tags = GetTags()
			@member_id = GetMemberID()
			@member_name = GetMemberName()
		end
		attr_reader :illust_id
		attr_reader :title
		attr_reader :caption
		attr_reader :tags
		attr_reader :member_name
		attr_reader :member_id
		
		# �^�C�g�����擾���Ă���
		def GetTitle()
			path = 'h1[@class="title"]'
			return @agent.page.at(path).inner_text
		end
		
		# �C���X�g�̋L�����e
		def GetCaption()
			path = 'div[@id="caption_long"]'
			return @agent.page.at(path).inner_text
		end
		
		# �^�O���擾
		def GetTags()
			path = 'div[@class=pedia]'
			path += '//a'
			
			# �E���Ă����^�O�̒�����֘A�y�[�W��r������
			all_tags = @agent.page.search(path)
			tags = Array.new
			for i in 0..all_tags.length-1
				all_tags[i].each{|k,v| 
					if v.include?("tags.php") then # tags.php�ȊO�̃^�O�͔r��
						tags << all_tags[i].inner_text 
					end
				}
			end
			return tags
		end
		
		# ���e�҂�Pixiv�����o�[ID�̎擾
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
		
		# Pixiv�����o�[�̖��O���擾����
		def GetMemberName()
			path = 'h2/a/img'
			link = @agent.page.search(path)
			member_name = ""
			for i in 0..link.length-1
				# img�^�O�̒���title�Ƃ����^�O�������āA�����Ƀ����o�[�̖��O���i�[����Ă���
				if link[i]['title'] != nil then
					member_name = link[i]['title']
					break
				end
			end
			return member_name
		end
	end
end