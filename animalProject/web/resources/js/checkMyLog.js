const items = document.querySelectorAll('input[name="item"]');
const bkTable = document.querySelector('#reserv_table');
const userid = document.querySelector('input[name="userid"]');
const hostMain = document.querySelector('.host_main');

// section1 버튼 클릭 시 main 내용 변경 이벤트 처리
for (let i = 0; i < items.length; i++) {
    items[i].addEventListener('change', function () {
        if (items[i].value === 'booking') {
            bkTable.style.display = 'table';
            hostMain.style.display = 'none';
            requestBkAjax();
        }
        if (items[i].value === 'host') {
            bkTable.style.display = 'none';
            hostMain.style.display = 'grid';
            requestHostAjax();
        }
    });
}
// 호스트 서비스 버튼 클릭 시 나에게 온 예약 출력 Ajax
function requestHostAjax() {
    const xhr = new XMLHttpRequest();
    const tbody = document.querySelector('.host_table table tbody');
    xhr.onload = function () {
        if (xhr.responseText) {
            const json = JSON.parse(xhr.responseText);
            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            for (let i in json.list) {
                const tr = document.createElement('tr');
                tbody.appendChild(tr);
                let pg = "";
                let kind = "";
                switch (json.list[i].pg) {
                    case '0': pg = "예약 신청"; break;
                    case '1': pg = "예약 완료"; break;
                    case '2': pg = "결제 대기"; break;
                    case '3': pg = "결제 완료"; break;
                }
                switch (json.list[i].kind) {
                    case '0': kind = "[당일] 펫시터 우리집으로 부르기 서비스"; break;
                    case '1': kind = "펫시터 우리집으로 부르기 서비스"; break;
                    case '2': kind = "[당일] 펫시터 집에 맡기기 서비스"; break;
                    case '3': kind = "펫시터 집에 맡기기 서비스"; break;
                }
                const tableForm = {
                    'bno': json.list[i].bno,
                    'kind': kind,
                    'name': decodeURIComponent(json.list[i].username),
                    'etc': decodeURIComponent(json.list[i].etc).replace(/\+/gi," "),
                    'date': json.list[i].indate +' ~ '+ json.list[i].outdate,
                    'price': json.list[i].price+'원',
                    'progress': pg,
                    'address': decodeURIComponent(json.list[i].addr).replace(/\+/gi," "),
                    'pno': json.list[i].pno
                }
                for (let j in tableForm) {
                    if(j === 'address'){
                        const hInput = document.createElement('input');
                        hInput.setAttribute("type","hidden");
                        hInput.setAttribute("name","addr");
                        hInput.setAttribute("value",tableForm[j]);
                        tr.appendChild(hInput);
                    } else if(j === 'pno'){
                        const hInput = document.createElement('input');
                        hInput.setAttribute("type","hidden");
                        hInput.setAttribute("name","pno");
                        hInput.setAttribute("value",tableForm[j]);
                        tr.appendChild(hInput);
                        
                    } else {
                        const td = document.createElement('td');
                        td.textContent = tableForm[j];
                        tr.appendChild(td);
                    }
                }

                tr.addEventListener('click', function(){
                    initMap(tableForm.address.split(",")[0], tableForm.name);
                    document.querySelector('#addr_text').textContent = tableForm.address;
                });
            }
        }
    }
    const requestData = 'userid=' + encodeURIComponent(userid.value);

    xhr.open("POST", "/doggybeta/hservice");
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}
// 예약/결제 내역 Ajax
function requestBkAjax() {
    const xhr = new XMLHttpRequest();
    const tbody = document.querySelector('#reserv_table > tbody');

    xhr.onload = function () {
        if (xhr.responseText) {

            const json = JSON.parse(xhr.responseText);
            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            for (let i in json.list) {
                const tr = document.createElement('tr');
                tbody.appendChild(tr);
                let pg = "";
                let kind = "";
                switch (json.list[i].progress) {
                    case '0': pg = "예약 신청"; break;
                    case '1': pg = "예약 완료"; break;
                    case '2': pg = "결제 대기"; break;
                    case '3': pg = "결제 완료"; break;
                }
                switch (json.list[i].kind) {
                    case '0': kind = "[당일] 펫시터 우리집으로 부르기 서비스"; break;
                    case '1': kind = "펫시터 우리집으로 부르기 서비스"; break;
                    case '2': kind = "[당일] 펫시터 집에 맡기기 서비스"; break;
                    case '3': kind = "펫시터 집에 맡기기 서비스"; break;
                }

                const tableForm = {
                    'bookingNo': json.list[i].bno,
                    'kind': kind,
                    'pname': decodeURIComponent(json.list[i].pname),
                    'addr': decodeURIComponent(json.list[i].addr).replace(/\+/gi, " "),
                    'price': json.list[i].price + "원",
                    'hostId': json.list[i].puserid,
                    'date': json.list[i].indate + " ~ " + json.list[i].outdate,
                    'pg': pg
                }
                for (let j in tableForm) {
                    const td = document.createElement('td');
                    td.textContent = tableForm[j];
                    tr.appendChild(td);
                }
            }
        }
    };

    const requestData = 'userid=' + encodeURIComponent(userid.value);

    xhr.open('POST', '/doggybeta/bklist');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(requestData);
}

// 페이지 로드시 예약/결제 내역 출력
document.addEventListener('DOMContentLoaded', () => { requestBkAjax(); });

