-- DAY10 2019.01.14

-- DDL
-- 테이블 무결성 제약조건(CONSTRAINT)

-- ━━ 1. NOT NULL CONSTRAINT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COLUMN에 값이 반드시 기록되어야 할 때 설정함. (웹상 필수입력항목)
-- COLUMN레벨에서만 설정할 수 있다.
CREATE TABLE TESTNN
(
 NNID     NUMBER(5) NOT NULL,
 NN_NAME  VARCHAR2(20)
);

-- 값 기록 테스트
INSERT INTO TESTNN (NNID, NN_NAME)
VALUES (NULL, NULL); -- ERROR. NNID에 NULL을 기록하려고 했기 때문. (NOT NULL 제약조건)

INSERT INTO TESTNN -- COLUMN이름 생략 : 테이블의 모든 COLUMN에 값 기록.
VALUES (1, NULL); -- 테이블의 COLUMN생성 순서와 자료형을 맞추어서 기록.

SELECT  * FROM TESTNN;

INSERT INTO TESTNN (NN_NAME)
VALUES ('ORACLE'); -- ERROR. 생략된 NNID에 자동으로 NULL이 입력됨. (NOT NULL 제약조건)

-- 테이블 레벨 적용 불가 : NOT NULL
CREATE TABLE TESTNN2
(
 NN_ID    NUMBER(5) CONSTRAINT T2_NNID NOT NULL,
 NN_NAME  VARCHAR2(10)
 -- 테이블레벨공간
 -- [CONSTRAINT 제약조건이름] 제약조건종류 (적용할 COLUMN이름)
 -- CONSTRAINT T2_NNNAME NOT NULL (NN_NAME) -> ERROR
);

-- ━━ 2. UNIQUE CONSTRAINT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 해당 COLUMN의 중복값(동일값) 입력을 막기 위한 제약조건.
-- 설정하면 동일한 값을 입력할 수 없다. (같은 값 두 번 기록 불가)
-- COLUMN레벨, TABLE레벨 모두 설정할 수 있다.
-- 복합키로도 설정할 수 있다.
CREATE TABLE TESTUN
(
 UN_ID    CHAR(3)   UNIQUE,
 UN_NAME  VARCHAR2(10)   NOT NULL
);

-- 기록테스트
INSERT INTO TESTUN VALUES ('AAA', 'ORACLE');
INSERT INTO TESTUN VALUES ('AAA', 'JAVA'); -- ERROR 「unique constraint violates」
INSERT INTO TESTUN VALUES ('AAB', 'JAVA');

SELECT  * FROM TESTUN;

CREATE TABLE TESTUN2
( -- COLUMN 레벨에서의 제약조건 설정
 UN_ID    CHAR(3)  CONSTRAINT T2_UNID UNIQUE,
 IN_NAME  VARCHAR2(10) CONSTRAINT T2_UNNAME NOT NULL
);

CREATE TABLE TESTUN3
( -- TABLE 레벨에서 제약조건 설정하기
 UN_ID    CHAR(3),
 UN_NAME  VARCHAR2(10) NOT NULL,
 CONSTRAINT T3_UNID UNIQUE (UN_ID)
);

-- ━━ 3. PRIMARY KEY CONSTRAINT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- TABLE에서 한 행(ROW)의 정보를 찾기 위한 값이 기록된 COLUMN에 적용함.
-- NOT NULL + UNIQUE
-- 한 TABLE에 한 번만 사용할 수 있다.
CREATE TABLE TESTPK
(
 PK_ID    NUMBER /*지정안하면 기본 7자리로 할당*/ PRIMARY KEY,
 PK_NAME  VARCHAR2(15) NOT NULL,
 PK_DATE  DATE
);
--기록테스트
INSERT INTO TESTPK VALUES (1, 'GILDONG','15/03/12');
INSERT INTO TESTPK VALUES (NULL, 'MUNSOO', SYSDATE); -- ERROR 「connot insert NULL into」
INSERT INTO TESTPK VALUES (1, 'MUNSOO', SYSDATE); -- ERROR 「unique constraint violates」
INSERT INTO TESTPK VALUES (2, 'MUNSOO', SYSDATE);

SELECT  * FROM TESTPK;

-- TABLE당 1회사용여부 테스트
CREATE TABLE TESTPK2
(
 PID    NUMBER PRIMARY KEY,
 PNAME  VARCHAR2(15) PRIMARY KEY -- ERROR 「table can have only one primary key」
);

CREATE TABLE TESTPK2
( -- COLUMN 레벨에서 제약조건 걸기
 PID    NUMBER CONSTRAINT P2_PID PRIMARY KEY,
 PNAME  VARCHAR2(15),
 PDATE  DATE
);

CREATE TABLE TESTPK3
( -- TABLE 레벨에서 제약조건 걸기
 PID    NUMBER,
 PNAME  VARCHAR2(15),
 PDATE  DATE,
 CONSTRAINT P3_PID PRIMARY KEY (PID)
);

-- ━━ 4. CHECK CONSTRAINT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COLUMN에 기록되는 값에 설정할 조건을 입력하는 제약조건.
-- CHECK( COLUMN이름 연산자 비교값 )
-- 비교값은 고정값이어야 한다. 유동값이면 ERROR (EG.SYSDATE)
CREATE TABLE TSETCHK
(
 C_NAME   VARCHAR2(15) CONSTRAINT TCK_NAME NOT NULL,
 C_PRICE  NUMBER(5) CHECK (C_PRICE BETWEEN 1 AND 99999),
 C_LEVEL  CHAR(1) CHECK (C_LEVEL IN ('A','B','C'))
);
-- 값 기록
INSERT INTO TSETCHK VALUES ('GALAXY S9', 75000, 'B');
INSERT INTO TSETCHK VALUES ('LG G7', 124000, 'B'); -- ERROR 「value larger than specified precision allowed
                                                   --         for this column」 CHECK위배
INSERT INTO TSETCHK VALUES ('LG G7', 0, 'B'); -- ERROR 「check constraint violated」
INSERT INTO TSETCHK VALUES ('LG G7', 65300, 'D'); -- ERROR 「check constraint violated」
INSERT INTO TSETCHK VALUES ('LG G7', 30690, 'A');

SELECT  * FROM TSETCHK;

CREATE TABLE TESTCHK2
(
 C_NAME    VARCHAR(15) PRIMARY KEY,
 C_PRICE   NUMBER(5) CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
 C_LEVEL   CHAR(1) CHECK (C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
 --C_DATE    DATE CHECK (C_DATE < SYSDATE) -- ERROR : 비교값은 반드시 리터럴(값)을 사용. SYSDAYE 사용불가.
 --C_DATE    DATE CHECK (C_DATE < TO_DATE('16/01/01', 'RR/MM/DD')) -- OK
 C_DATE    DATE CHECK (C_DATE < TO_DATE('16/01/01', 'YYYY/MM/DD')) -- 이거 되는데 BUG임.
);
DROP TABLE CONSTRAINT_EMP;
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SAMPLE SCRIPT 적어보기
CREATE TABLE CONSTRAINT_EMP
(
 EID        CHAR(3) CONSTRAINT PKEID PRIMARY KEY,
 ENAME      VARCHAR(20) CONSTRAINT NENAME NOT NULL,
 ENO        CHAR(14) CONSTRAINT NENO NOT NULL CONSTRAINT UENO UNIQUE,
 EMAIL      VARCHAR2(25) CONSTRAINT UEMAIL UNIQUE,
 PHONE      VARCHAR2(12),
 HIRE_DATE  DATE DEFAULT SYSDATE,
 JID        CHAR(2) CONSTRAINT FKJID REFERENCES JOB ON DELETE SET NULL,
 SALARY     NUMBER,
 BONUS_PCT  NUMBER,
 MARRIAGE   CHAR(1) DEFAULT 'N' CONSTRAINT CHK CHECK (MARRIAGE IN('Y','N')),
 MID        CHAR(3) CONSTRAINT FKMID REFERENCES CONSTRAINT_EMP ON DELETE SET NULL,
 DID        CHAR(2),
 CONSTRAINT FKDID FOREIGN KEY (DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ━━ 5. FOREIGN KEY CONSTRAINT ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 외래키, 외부키
-- 다른 TABLE에서 제공하는 값만 사용할 수 있는 COLUMN을 의미.
-- 제공되지 않는 값을 사용하면 ERROR

-- COLUMN레벨에서 설정
-- [CONSTRAINT 이름] REFERENCES 참조테이블이름 [(참조할 COLUMN이름)]
-- TABLE레벨에서 설정
-- [CONSTRAINT 이름] FOREIGN KEY (적용할 COLUMN이름) REFERENCES 참조테이블 [(참조할 COLUMN이름)]
-- NULL은 사용할 수 있다.
CREATE TABLE TESTFK
(
 EMP_ID     CHAR(3) REFERENCES EMPLOYEE, -- 참조COLUMN이 생략되면 PRIMARY KEY COLUMN이 자동할당
 DEPT_ID    CHAR(2) CONSTRAINT TFK_DID REFERENCES DEPARTMENT (DEPT_ID),
 JOB_ID     CHAR(2),
 --테이블레벨
 CONSTRAINT TFK_JID FOREIGN KEY (JOB_ID) REFERENCES JOB (JOB_ID)
);
-- 기록테스트
-- 서로 연결된 TABLE과 COLUMN에 기록되어 있는 값만 사용할 수 있다.
INSERT INTO TESTFK VALUES ('300', NULL, NULL); -- ERROR 「integrity constraint - parent key not found」
                                               -- 제공되지 않은 값 사용
INSERT INTO TESTFK VALUES ('100', NULL, NULL);
INSERT INTO TESTFK VALUES ('200', '70', NULL); -- ERROR 「integrity constraint - parent key not found」
                                               -- 제공되지 않은 값 사용 : 70은 없는 부서코드
INSERT INTO TESTFK VALUES ('200', '90', NULL);
INSERT INTO TESTFK VALUES ('124', '80', 'J9'); -- ERROR 「integrity constraint - parent key not found」
                                               -- 제공되지 않은 값 사용 : J9는 없는 직급코드
INSERT INTO TESTFK VALUES ('124', '80', 'J7');

SELECT  * FROM TESTFK;

-- 외래키 제약조건에서 PARENT KEY가 될 수 있는 COLUMN은
-- PRIMARY KEY 또는 UNIQUE 제약조건이 설정된COLUMN이다.
CREATE TABLE NOPK
(
 ID     CHAR(3),
 NAME   VARCHAR2(10)
);
--CREATE TABLE TESTFK2 -- ERROR 「referenced table does not have a primary(unique) key」
--(
-- FID    CHAR(3) REFERENCES NOPK /*(ID)*/,
-- FNAME  VARCHAR2(10)
--);

CREATE TABLE TESTUN5
(
 ID     CHAR(3) UNIQUE,
 NAME   VARCHAR2(10)
);

CREATE TABLE TESTFK2 -- PASS
(
 FID    CHAR(3) REFERENCES TESTUN5 (ID),
 FNAME  VARCHAR2(10)
);

-- 여러 개의 COLUMN을 묶어서 UNIQUE 제약조건이나 PRIMARY KEY 제약조건을 설정한 복합키를 참조할 경우
CREATE TABLE TEST_COMPLEX
(
 ID     NUMBER,
 NAME   VARCHAR2(10),
 UNIQUE (ID, NAME)
);

INSERT INTO TEST_COMPLEX VALUES (100, 'ORACLE');
INSERT INTO TEST_COMPLEX VALUES (NULL, NULL);
INSERT INTO TEST_COMPLEX VALUES (100, 'JAVA'); -- 개별 UNIQUE였다면 ERROR.
INSERT INTO TEST_COMPLEX VALUES (300, NULL);
INSERT INTO TEST_COMPLEX VALUES (NULL, 'JAVA');
INSERT INTO TEST_COMPLEX VALUES (NULL, 'JAVA'); -- ERROR 「unique constraint violates」
INSERT INTO TEST_COMPLEX VALUES (100, 'JAVA'); -- ERROR 「unique constraint violates」

SELECT  * FROM TEST_COMPLEX;

-- 복합키를 참조키로 설정할 경우
CREATE TABLE TESTFK4 -- PASS
(
 ID     NUMBER,
 NAME   VARCHAR2(10),
 PRICE  NUMBER,
 FOREIGN KEY (ID, NAME) REFERENCES TEST_COMPLEX (ID, NAME)
);

/*CREATE TABLE TESTFK5
(
 ID     NUMBER REFERENCES TEST_COMPLEX (ID),
 NAME   VARCHAR2(10) REFERENCES TEST_COMPLEX (NAME), -- 이렇게 따로 나누어 설정해주어도 ERROR
 PRICE  NUMBER --,
 -- FOREIGN KEY (ID) REFERENCES TEST_COMPLEX (ID, NAME) -- ERROR
); */

-- 외래키가 설정된 COLUMN의 값이 사용중이면, 부모키는 절대 삭제할 수 없다.
DELETE FROM DEPARTMENT
WHERE  DEPT_ID = '90'; -- ERROR 「integrity constraint violated - child record found」 
                       -- EMPLOYEE 테이블에 DEPT_ID COLUMN의 '90'이 사용되고 있음.
                       
-- FOREIGN KEY 제약조건 설정시 삭제옵션을 추가할 수 있다. : DELETION OPITION
-- 기본 원칙(RESTRICED) : CHILD RECORD가 존재하면 PARENT는 삭제할 수 없다.
-- ON DELETE SET NULL, ON DELETE CASCADE 의 두 가지를 설정할 수 있다.

-- ON DELETE SET NULL 추가 ▶ PARENT 삭제시 CHILD RECORDE값을 NULL로 바꿈
CREATE TABLE PRODUCT_STATE
(
 PSTATE     CHAR(1) PRIMARY KEY,
 PCOMMENT   VARCHAR2(10)
);

INSERT INTO PRODUCT_STATE VALUES ('A', '최고급');
INSERT INTO PRODUCT_STATE VALUES ('B', '보통');
INSERT INTO PRODUCT_STATE VALUES ('C', '하급');

SELECT  * FROM PRODUCT_STATE;

CREATE TABLE PRODUCT
(
 PNAME      VARCHAR2(20) PRIMARY KEY,
 PPRICE      NUMBER CHECK (PPRICE > 0),
 PSTATE     CHAR(1) REFERENCES PRODUCT_STATE ON DELETE SET NULL
);

INSERT INTO PRODUCT VALUES ('갤럭시', 653000, 'A');
INSERT INTO PRODUCT VALUES ('G7', 740000, 'B');
INSERT INTO PRODUCT VALUES ('Mac Pro', 2500000, 'C');

SELECT  * FROM PRODUCT;

-- DELETE TEST
DELETE  FROM PRODUCT_STATE
WHERE   PSTATE = 'A';

COMMIT;
SELECT  * FROM PRODUCT; --→ A가 입력되어있던 것이 NULL로 변경됨.
SELECT  * FROM PRODUCT_STATE; --→ A가 없어졌음.

-- ON DELETE CASCADE TEST
-- 제공되는 PARENT가 삭제되면 이 값을 사용하는 CHILD RECORD도 같이 지워짐.
CREATE TABLE PRODUCT2
(
 PNAME      VARCHAR2(20) PRIMARY KEY,
 PPRICE     NUMBER,
 PSTATE     CHAR(1) REFERENCES PRODUCT_STATE (PSTATE) ON DELETE CASCADE
);

INSERT INTO PRODUCT2 VALUES ('Mac Pro', 2500000, 'B');
INSERT INTO PRODUCT2 VALUES ('Mac Air', 1250000, 'C');
SELECT  * FROM PRODUCT2;

--PARENT 삭제
DELETE FROM PRODUCT_STATE
WHERE  PSTATE = 'B';

COMMIT;
-- 같이 삭제되었는지 확인
SELECT  * FROM PRODUCT_STATE;
SELECT  * FROM PRODUCT2;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- SUB QUERY를 활용한 테이블 생성 구문
CREATE TABLE TABLE_SUBQUERY1
 AS SELECT     EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
    FROM       EMPLOYEE
    LEFT JOIN  DEPARTMENT USING (DEPT_ID)
    LEFT JOIN  JOB USING (JOB_ID);
    
SELECT  * FROM TABLE_SUBQUERY1;

-- DESCRIBE TABLE이름
-- DESC 테이블이름;
-- 테이블의 구조를 확인하는 명령어
DESC TABLE_SUBQUERY1;

-- 직원 테이블에서 90번 부서에 소속된 직원 정보만 따로 EMP_COPY90 테이블에 저장하려면
CREATE TABLE EMP_COPY90
 AS SELECT   *
    FROM     EMPLOYEE
    WHERE    DEPT_ID = '90';

SELECT  * FROM EMP_COPY90;
DESC EMP_COPY90;

-- 복사본 테이블 만들기
CREATE TABLE EMP_COPY
 AS SELECT    *
    FROM      EMPLOYEE; --→ 테이블 복사
    
SELECT  * FROM EMP_COPY;
DESC EMP_COPY; --→ SUB QUERY를 이용해서 기존 TABLE을 복사할 경우,
                -- COLUMN이름, 자료형, NOT NULL CONSTRAINT, 값만 복사가 된다.
                -- 나머지 제약조건은 복사되지 않음.
                
-- 제약조건 관련 데이터딕셔너리 확인
-- USER_CONSTRAINTS
SELECT   * FROM USER_CONSTRAINTS;

SELECT   CONSTRAINT_NAME, CONSTRAINT_TYPE 
FROM     USER_CONSTRAINTS
WHERE    TABLE_NAME = 'EMP_COPY';
