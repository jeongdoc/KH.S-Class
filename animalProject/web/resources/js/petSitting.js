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
const imageBox_pic = document.querySelector('.image_box .image_box_pic');

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

// 시설/장소 사진 추가 multiple 파일 업로드

const ppicsFile = document.getElementById('place_pics');
const uploadBtn = document.getElementById('ppics_upload');
const ppicsText = document.getElementById('ppics-text');
uploadBtn.addEventListener('click', function(e){
	e.preventDefault();
	ppicsFile.click();
});
// 시설/장소 사진 추가 버튼 이벤트
ppicsFile.addEventListener('change', function(e){
	showPPics(e.target);
	if(ppicsFile.value){
		ppicsText.innerHTML = ppicsFile.files.length+' files selected';
		
	}
});
// 시설/장소 이미지 프리뷰 + multiple 파일명 합쳐서 hidden input에 기록
function showPPics(input){
	const imgs = [document.querySelector('.pp1'),document.querySelector('.pp2'),document.querySelector('.pp3')];
	let fileList ="";
	for(let i = 0; i < imgs.length; i++){
		if(input.files[i] && (realFile.files[0].name !== input.files[i].name)){
			const reader = new FileReader();
			reader.onload =function(e){
				imgs[i].setAttribute('src',e.target.result);
			}
			reader.readAsDataURL(input.files[i]);
			fileList += input.files[i].name + "/";
		}
	}
	document.querySelector('#fileList').setAttribute('value',fileList);
}


