// 펫시팅 신청 메뉴 클릭 시 발생 이벤트
const psReglink = document.getElementById('pet_reg__btn');
const psRegBox = document.querySelector('.ps_reg_form');
const xBtn = document.querySelector('.ps_reg_form .close');

psReglink.addEventListener('click', (e) => {
	e.preventDefault();
	psRegBox.style.display = 'grid';
});

xBtn.addEventListener('click', ()=>{
	psRegBox.style.display = 'none';
});

// 이미지 파일 업로드 시 발생 이벤트
const realFile = document.getElementById("real-file");
const customBtn = document.getElementById("fake-file-btn");
const customTxt = document.getElementById("file-text");
const imageBox_pic = document.querySelector('.section3 .image_box .image_box_pic');

customBtn.addEventListener('click', () =>{
	realFile.click();
});

function readURL(input){
	if(input.files && input.files[0]){
		const reader = new FileReader();
		reader.onload = function(e){
			imageBox_pic.setAttribute('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

realFile.addEventListener('change', (e) =>{
	// 업로드 하면 버튼 옆에 파일명(경로제외) 출력 됨.
	readURL(e.target);
	 if(realFile.value)
	 	customTxt.innerHTML = realFile.value.match(/[\/\\]([\w\d\s\.\-\(\)]+)$/)[1];
});

// 펫시터 등록 버튼 클릭 시 발생 이벤트
const submitBtn = document.getElementById('submit-btn'); 

// 필수 입력항목 체크
function checkInputs(obj){
	for(let i in obj){
		obj[i].style.borderBottom = "1px solid white";
		if(obj[i].value === ""){
			obj[i].style.borderBottom = "1px solid red";
			return false;
		} 
	}
		return true;
}
submitBtn.addEventListener('click', (e)=>{
	e.preventDefault();
		const toSend = {
		userid : document.querySelector('.section1 .input_id'),
		username : document.querySelector('.section1 .input_name'),
		phone : document.querySelector('.section2 .input_phone'),
		email : document.querySelector('.section2 .input_email'),
		address : document.querySelector('.input_addr'),
		price : document.querySelector('.section2 .input_price'),
	}
	if(checkInputs(toSend) && toSend.agree.value === 'agree'){
		// 모든 인풋 정보가 들어왔을경우		
		const alertBox = document.querySelector('.ps_reg_form_popup_box');
		alertBox.style.display = "flex";
	} 
});

