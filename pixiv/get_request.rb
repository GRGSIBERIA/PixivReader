=begin
����URL�ɑ΂���GET���\�b�h�Ń��N�G�X�g�𑗂邽�߂̃t�@�C��
����ł̓p�����[�^�n����URL��邾���̂��Ƃ�������ĂȂ�
=end
require 'net/http'

module Pixiv
	# GET���N�G�X�g�𑗂邽�߂̃N���X
	class GetRequest

		# ����������̂Ƀy�[�W�̎�ނ��w�肷��
		# ��������illust��member�̂ǂ��炩
		def initialize(page_type)
			@request_url = "www.pixiv.net"
			@page_url = ""
			@param_value_pair = Hash::new
			@set_param_flag = false
			
			# PageType�̓��e����ǂ̃y�[�W�Ƀ��N�G�X�g�𑗂肽���̂����f����
			case page_type
			when "member"
				@page_url = "/member.php"
			when "illust"
				@page_url = "/member_illust.php"
			end
		end
		
		# GET�ő���p�����[�^�ƒl���w�肷��
		def SetParameter(parameter, value)
			if @set_param_flag == false then
				@page_url += "?"
				@set_param_flag = true
			else
				@page_url += "&" 
			end
			@page_url += parameter.to_s +  "=" + value.to_s
		end
		
		# GET�Ń��N�G�X�g�𑗐M���A���̌��ʂ��擾����
		def SendRequest()	
			# URL��W�J����GET�ŃA�N�Z�X�Aresponse�Ɍ��ʂ�����
			request = Net::HTTP::Get.new(@page_url)
			response = Net::HTTP.start(@request_url, 80) {|http|
				http.request(request)
			}
			return response.body	# �{���݂̂�Ԃ�
		end
		
		# ���N�G�X�g�𑗂�URL��W�J����
		def GetRequestURL()
			return "http://" + @request_url + @page_url
		end
	end
end