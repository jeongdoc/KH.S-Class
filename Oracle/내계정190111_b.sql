-- DAY9 2019.01.11 -②

-- ━━━ DDL (Data Definition Language) : 데이터 정의어 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CREATE, ALTER, DROP
-- 데이터베이스 객체 만들고 수정, 삭제하는 구문
-- 테이블(TABLE), 뷰(VIEW), 인덱스(INDEX), 시퀀스(SEQUENCE), 사용자(USER),
-- 롤(ROLE), 프로시져(PROCEDURE), 함수(FUNCTION), 트리거(TRIGGER), 동의어(SYNONYM)

/* 
 테이블만들기
 : CREATE TABLE 테이블명 (
        COLUMN이름 자료형(사이즈) DEFAULT 기본값 제약조건,
        COLUMN이름 자료형(사이즈),
                            ·
                            ·
                            ·
        COLUMN에 지정할 제약조건 
 )
*/
CREATE   TABLE TEST
(
 ID   NUMBER(5),
 NAME CHAR(10 CHAR),
 ADDRESS VARCHAR2(50)
);
-- 테이블 구조 확인 : DESC / DESCRIBE 테이블명;
DESC TEST;

SELECT * FROM TEST;

INSERT INTO TEST ( ID, NAME, ADDRESS )
VALUES           ( 10023, '고품격', '서울시 강남구 역삼동 77');

INSERT INTO TEST -- 컬럼명 생략 : 컬럼생성순으로 정보입력
VALUES           ( 10270, '뚜뚜비', '경남 통영시 5995');

INSERT INTO TEST ( ID, NAME ) -- ADDRESS는 입력X -> NULL처리됨.
VALUES           ( 03341, '붕어빵');

INSERT INTO TEST
VALUES           ( 420, '뽀빠이', NULL);
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--DROP TABLE ORDERS;
CREATE TABLE ORDERS
(
 ORDERNO CHAR(4),
 CUSTNO CHAR(4),
 ORDERDATE DATE DEFAULT SYSDATE,
 SHIPDATE DATE,
 SHIPADDRESS VARCHAR2(40),
 QUANTITY NUMBER
);
COMMENT ON COLUMN ORDERS.ORDERNO IS '주문번호';
COMMENT ON COLUMN ORDERS.CUSTNO IS '고객번호';
COMMENT ON COLUMN ORDERS.ORDERDATE IS '주문일자';
COMMENT ON COLUMN ORDERS.SHIPDATE IS '배송일자';
COMMENT ON COLUMN ORDERS.SHIPADDRESS IS '배송주소';
COMMENT ON COLUMN ORDERS.QUANTITY IS '주문수량';

/*
 공지사항 정보를 저장할 테이블 : NOTICE
 컬럼 :
 글번호(숫자), 글제목(가변문자 30바이트), 작성자아이디(가변문자 15바이트),
 작성날짜(날짜), 작성내용(가변문자 2000바이트), 첨부파일경로명(가변문자 50바이트),
 컬럼명 :
 NOTICE_NO, NOTICE_TITLE, NOTICE_WRITER, NOTICE_DATE, NOTICE_CONTENT, FILE_PATH
 작성날짜의 기본값은 SYSDATE
*/
CREATE TABLE NOTICE
(
 NOTICE_NO NUMBER,
 NOTICE_TITLE VARCHAR2(30),
 NOTICE_WRITER VARCHAR2(15),
 NOTICE_DATE DATE DEFAULT SYSDATE,
 NOTICE_CONTENT VARCHAR2(2000),
 FILE_PATH VARCHAR2(50)
);
-- 첫 번째 글 추가 :
-- 1, '첫번째 공지글', 'user01', '안녕하세요. 공지사항을 알려드립니다'
INSERT INTO NOTICE ( NOTICE_NO, NOTICE_TITLE, NOTICE_WRITER, NOTICE_DATE, NOTICE_CONTENT ) 
VALUES             ( 1, '첫번째 공지글', 'user01', DEFAULT, '안녕하세요. 공지사항을 알려드립니다' );

SELECT * FROM NOTICE;
-- 두 번째 글 추가 :
-- 글번호의 가장 큰 값 + 1, '두번째 공지글', 'user02', '알립니다.두번째'
INSERT INTO NOTICE ( NOTICE_NO, NOTICE_TITLE, NOTICE_WRITER, NOTICE_DATE, NOTICE_CONTENT )
VALUES             ( (SELECT MAX(NOTICE_NO) FROM NOTICE) +1, '두번째 공지글', 'user02', DEFAULT ,'알립니다. 두번째' );

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '글번호';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '글제목';
COMMENT ON COLUMN NOTICE.NOTICE_WRITER IS '작성자아이디';
COMMENT ON COLUMN NOTICE.NOTICE_DATE IS '작성날짜';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '작성내용';
COMMENT ON COLUMN NOTICE.FILE_PATH IS '첨부파일경로명';

-- ━━ DML (Data Manipulation Language) : 데이터 조작어 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- INSERT, UPDATE, DELETE, TRUNCATE
-- 테이블에 데이터를 추가 기록하거나 기록된 값을 수정, 행을 삭제하는 구문
CREATE TABLE DEPT
(
 DEPT_ID CHAR(2),
 DEPT_NAME VARCHAR2(30)
);
SELECT   COUNT(*) FROM DEPT;
INSERT INTO DEPT VALUES ('20', '회계팀'); -- 테이블에 데이터 기록
SELECT   COUNT(*) FROM DEPT;
INSERT INTO DEPT VALUES ('10', '인사팀');
SELECT   COUNT(*) FROM DEPT;