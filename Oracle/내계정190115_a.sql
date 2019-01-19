-- DAY11 2019.01.15 -①
/*
 테이블명 : PHONEBOOK
 컬럼명 : ID CHAR(3) 기본키(저장이름 : PK_PBID)
 PNAME    VARCHAR2(20) 널 사용못함.
                        (NN_PBNAME)
 PHONE    VARCHAR2(15) 널 사용못함.
                        (NN_PBPHONE)
                        중복값 입력못함.
                        (UN_PBHONE)
 ADDRESS  VARCHAR2(100) 기본값 지정함
                        '서울시 구로구'
 NOT NULL을 제외하고, 모두 테이블 레벨에서 지정함.
*/
CREATE TABLE PHONEBOOK
(
 ID      CHAR(3),
 PNAME   VARCHAR2(20) CONSTRAINT NN_PNAME NOT NULL,
 PHONE   VARCHAR2(15) CONSTRAINT NN_PBPHONE NOT NULL,
 ADDRESS VARCHAR2(100) DEFAULT '서울시 구로구',
 CONSTRAINT PK_PBID PRIMARY KEY (ID),
 CONSTRAINT UN_PBPHONE UNIQUE (PHONE)
);
INSERT INTO PHONEBOOK VALUES ('Br1', '한길준', '010-0000-1111', DEFAULT);
SELECT  * FROM PHONEBOOK;

-- DATA DICTIONARY (데이터사전)
-- 사용자가 생성한 모든 객체정보는 테이블단위로 저장되고 있음.
-- USER_CONSTRAINTS
DESC USER_CONSTRAINTS;

SELECT  CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM    USER_CONSTRAINTS
WHERE   TABLE_NAME = 'PHONEBOOK';
/*
 CONSTRAINT TYPE
 ● P : PRIMARY KEY
 ● U : UNIQUE
 ● C : CHECK, NOT NULL
 ● R : FOREIGN KEY
*/
-- SUB QUERY 사용해서 테이블을 만들 때
-- 데이터는 복사하지 않고 테이블 구조만 가져다쓰고 싶을 경우.
-- SUB QUERY의 WHERE절에 「WHERE 1 = 0」 작성
CREATE TABLE DEPT_COPY
AS SELECT   *
   FROM     DEPARTMENT
   WHERE    1 = 0;
   
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;

-- SUB QUERY로 새로운 테이블을 만들 때 SUB QUERY의 COLUMN이름을 사용하지 않고
-- 색다른 COLUMN이름을 구성하고 싶을 경우.
-- 한글로 정해주면 전부 한글로 작성해야함. 또한 SELECT한 COLUMN에게 전부 부여해야한다.
CREATE TABLE JOB_COPY (직급코드, 직급명, 최저급여, 최고급여)
AS SELECT   *
   FROM     JOB;
   
DESC JOB_COPY;

SELECT  * FROM JOB_COPY;

-- ANOTHER WAY : 원하는 COLUMN만 따로 이름지어줄 수 있다.
CREATE TABLE DCOPY
AS SELECT   DEPT_ID AS DID,
            DEPT_NAME AS DNAME,
            LOC_ID AS LID
   FROM     DEPARTMENT;
   
DESC DCOPY;
SELECT  * FROM DCOPY;

-- SUB QUERY로 테이블을 만들 때 COLUMN을 바꾸면서 제약조건도 추가할 수 있다.
-- NOT NULL만 복사되는 것이 원칙.
-- FOREIGN KEY CONSTRAINT -> 추가할 수 없음.
CREATE TABLE TSUB3 (EID PRIMARY KEY, 
                    ENAME, 
                    SALARY , --CHECK (SALARY > 2000000), -> 2백만보다 작은 값이 있어서 ERROR. 
                    DID, --REFERENCES DEPARTMENT, -> FOREIGN KEY 설정이기 때문에 ERROR
                    JTITLE) --NOT NULL) -> OUTER JOIN으로 NULL이 들어있어서 ERROR. NULL이 없다면 가능.
AS  SELECT    EMP_ID, EMP_NAME, SALARY, DEPT_ID, JOB_TITLE
    FROM      EMPLOYEE
    LEFT JOIN DEPARTMENT USING (DEPT_ID)
    LEFT JOIN JOB USING (JOB_ID);
-- 제약조건을 위의 작성문처럼 설정하고 싶다면 SUB QUERY를 수정하면 됨.
CREATE TABLE TSUB3 (EID PRIMARY KEY, 
                    ENAME, 
                    SALARY CHECK (SALARY > 2000000), 
                    DID,
                    JTITLE NOT NULL) 
AS  SELECT    EMP_ID, EMP_NAME, SALARY, DEPT_ID, 
              NVL(JOB_TITLE, '미정')
    FROM      EMPLOYEE
    LEFT JOIN DEPARTMENT USING (DEPT_ID)
    LEFT JOIN JOB USING (JOB_ID)
    WHERE     SALARY > 2000000; 
             --AND JOB_ID IS NOT NULL 하거나 NVL설정;