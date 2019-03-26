/**
 * 
 */
function checkid() {
		//jQuery.ajax() 사용
		var id=$('#userid').val();
		var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
		
		if(!id) {
			alert('아이디를 입력해주세요.');
			$('#userid').focus();
			return false;
		}
		else if(!getCheck.test($('#userid').val())){
	        alert("영어 소문자와 숫자만 사용할 수 있습니다.");
	        $("#userid").val("");
	        $("#userid").focus();
	        return false;
	    }
		
		$.ajax({
			url: '/doggybeta/memberidchk',
			type: 'post',
			data: {userid: $('#userid').val()}, 
			success: function(data) {
				console.log("success"+data);
				
				if(data=="ok"){
					alert('사용할 수 있는 아이디입니다.');
					$('#username').focus();
				} else {
					alert('이미 사용중인 아이디입니다.\n'+'다른 아이디를 입력해주세요');
					$('#userid').select();
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log("error : "+jqXHR+","+textStatus+","+errorThrown);
			}
		}); //ajax
		
		return false; //클릭 이벤트 전달받음
	} // 아이디 중복 확인 함수 close;
	function admit() {
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var e = $('#email').val();
		
		if(!e || !regExp.test(e)) {
			alert('올바른 형식의 이메일주소를 입력해주세요.');
			$('#email').select();
		}
		else {
			alert('인증번호 전송이 완료되었습니다.');
				
			$.ajax({
				url: '/doggybeta/admitmember',
				type: 'post',
				dataType: 'json',
				data: {email: $('#email').val()},
				success: function(data) {
					var obj = JSON.parse(data.keycode);
					$('#number2').val(obj);
					/* console.log("data : " + obj); */ //데이터 잘 넘어오는지 확인
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log("error : "+jqXHR+","+textStatus+","+errorThrown);
				}
			}); //ajax
		} //else
		return false;
	} // 인증번호 전송 클릭함수
	
	function confirmNum() {
		var n2 = $('#number2').val();
		var n1 = $('#number').val();
			if(n1==n2 && n1!='' && n2!='') {
				alert('인증에 성공하였습니다!');
				$('#signupbtn').prop('disabled', false).css("background-color", "");
			} else if(!n1) {
				alert('인증번호를 입력해주세요');
				$('#signupbtn').prop('disabled', true).css('background-color','gray');
			} else {
				alert('인증번호를 다시 입력해주세요!');
				$('#signupbtn').prop('disabled', true).css('background-color','gray');
			 }
			return false;
	}; //인증번호 일치여부 확인하는 함수
	
	$(function() {
		//암호 확인입력상자의 focus가 사라졌을 때
			$('#userpwd2').blur(function() {
				console.log('포커스사라짐');
				var pwd1=$('#userpwd1').val();
				var pwd2=$('#userpwd2').val();
				var userid=$('#userid').val();
				
				if(!pwd1) {
					alert('비밀번호는 필수 입력사항입니다.')
					$('#signupbtn').prop('disabled', true).css('background-color','gray');
					$('#userpwd1').select();
				}
				else if(pwd1!=pwd2) {
					alert('암호가 일치하지 않습니다.\n'+'다시 입력하세요');
					$('#signupbtn').prop('disabled', true).css('background-color','gray');
					$('#userpwd1').select();
				} else if((pwd1 == userid) || (pwd2 == userid)) {
					alert('아이디와 동일하게 비밀번호를 설정할 수 없습니다')
					('#signupbtn').prop('disabled', true).css('background-color','gray');
					$('#userpwd1').select();
					pwd1 = '';
				} else {
					$('#signupbtn').prop('disabled', false).css("background-color", "");
				}
			});
	}); //암호 함수
	
	$(function(){
	    $("#phone").on('keydown', function(e){
	       // 숫자만 입력받기
	    var trans_num = $('#phone').val().replace(/-/gi,'');
		var k = e.keyCode;
					
		if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687) || k==32 || k==229 || (k>=45032 && k<=55203)))
		{
	  	    e.preventDefault();
		}
		//function(e) 시작
	    }).on('blur', function() { // 포커스를 잃었을때 
	        if($('#phone').val() == '') return;
	        // 기존 번호에서 - 를 삭제
	        var trans_num = $('#phone').val().replace(/-/gi,'');
	      
	        // 입력값이 있을때만 실행
	        if(trans_num != null && trans_num != '') {
	            // 총 핸드폰 자리수는 11글자이거나, 10자
	            if(trans_num.length==11 || trans_num.length==10) {   
	                // 유효성 체크
	                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
	                if(regExp_ctn.test(trans_num)) {
	                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿈
	                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
	                    $('#phone').val(trans_num);
	                } else {
	                    alert("유효하지 않은 전화번호 입니다.");
	                    $('#phone').val("");
	                    $('#phone').focus();
	                    }
	            } else {
	                alert("유효하지 않은 전화번호 입니다.");
	                $('#phone').val("");
	                $('#phone').focus();
	            }
	      }
	  });  
	    return false;
	}); //phone 유효성 함수 close