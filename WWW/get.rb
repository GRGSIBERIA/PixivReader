=begin
Pixiv��Get���N�G�X�g�𓊂��邽�߂̃N���X
=end
require 'net/http'
require './WWW/page_type.rb'

# GET���N�G�X�g�𑗂�N���X
class GetRequest

	# ����������̂Ƀy�[�W�̎�ނ��w�肷��
	# PageType�N���X�̒萔���g���̂𐄏�
	def initialize(page_type)
		@request_url = "www.pixiv.net"
		@page_url = ""
		@param_value_pair = Hash::new
		@set_param_flag = false
		
		# PageType�̓��e����ǂ̃y�[�W�Ƀ��N�G�X�g�𑗂肽���̂����f����
		case page_type
		when PageType::MEMBER
			@page_url = "/member.php"
		when PageType::MEMBER_ILLUST
			@page_url = "/member_illust.php"
		end
	end
	
	# GET�ő���p�����[�^�ƒl���w�肷��
	def SetParameter(parameter, value)
		if @set_param_flag == false then
			@page_url += "?"
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
end

request = GetRequest.new(PageType::MEMBER)
request.SetParameter("id", 32777)

open("test.txt", "w") {|f| f.write request.SendRequest()}