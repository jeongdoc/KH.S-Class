 -- DAY11 2019.01.15 -③
/*
 ━━ DML (Data Manipulation Language : 데이터 조작어) ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 INSERT, UPDATE, DELETE의 세 종류.
 TABLE에 데이터를 추가하거나, 기록되어있는 데이터를 수정하거나, 기록되어 있는 행(ROW)을 삭제하는 구문.
 INSERT문 : 행(ROW)을 추가함. (행 개수 증가)
 UPDATE문 : 데이터를 변경함. (행 개수 변화 X)
 DELETE문 : 해당 데이터를 포함한 행을 삭제함. (행 개수 감소)
 TRUNCATE문 : 테이블의 모든 행(ROW)을 삭제하는 구문.
*/

-- UPDATE문
-- UPDATE TABLE이름
-- SET 컬럼이름 = 변경할 값, 컬럼이름 = 변경할 값..
-- WHERE COLUMN이름 비교연산자 비교값;
SELECT  * FROM DCOPY;
DROP TABLE DCOPY;

CREATE TABLE DCOPY
AS  SELECT  * FROM DEPARTMENT;
SELECT * FROM DCOPY;

UPDATE DCOPY
SET DEPT_NAME = '인사팀';

ROLLBACK;

UPDATE DCOPY
SET DEPT_NAME = '인사팀'
WHERE DEPT_ID = '10';

-- UPDATE문에 SUB QUERY 사용할 수 있음
-- SET절과 WHERE절에서 사용한다.
-- SET COLUMN이름 = (SUB QUERY)
-- WHERE COLUMN이름 비교연산자 (SUB_QUERY)

-- 심하균의 직급코드와 급여를 성해교 직원의 값을 같은 값으로 변경하시오.
UPDATE  EMPLOYEE
SET JOB_ID = (SELECT    JOB_ID FROM EMPLOYEE
              WHERE EMP_NAME  = '성해교'),
    SALARY = (SELECT    SALARY FROM EMPLOYEE
              WHERE EMP_NAME = '성해교')
WHERE   EMP_NAME = '심하균';
--다중열단일행으로 변경해보면
UPDATE  EMPLOYEE
SET (JOB_ID, SALARY) = (SELECT  JOB_ID, SALARY
                        FROM    EMPLOYEE
                        WHERE   EMP_NAME = '성해교')
WHERE   EMP_NAME ='심하균';

-- CONFIRM
SELECT  EMP_NAME, JOB_ID, SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME IN ('심하균','성해교');

ROLLBACK;

-- DEFAULT가 설정된 COLUMN값을 변경할 때 특정 값 대신 DEFAULT 키워드 사용해도 됨
SELECT  EMP_ID, EMP_NAME, MARRIAGE
FROM    EMPLOYEE
WHERE   EMP_ID = '210';

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '210';

ROLLBACK;

-- WHERE절에서도 SUB QUERY사용할 수 있음
-- 해외영업2팀 직원들의 보너스포인트를 0.3으로 변경하시오
UPDATE  EMPLOYEE
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT  DEPT_ID
                 FROM    DEPARTMENT
                 WHERE   DEPT_NAME = '해외영업2팀');
-- 확인
SELECT  EMP_NAME, DEPT_ID, BONUS_PCT
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT   DEPT_ID
                   FROM     DEPARTMENT
                   WHERE    DEPT_NAME = '해외영업2팀');           
ROLLBACK;

-- INSERT INTO문
-- 테이블에 새 행을 추가하는 구문
-- 새로운 데이터 기록 저장시 사용
/*
 INSERT INTO 테이블이름 [(컬럼이름, 컬럼이름, 컬럼이름,...)]
 VALUES (기록할 값, 기록할 값, ...);
*/
CREATE TABLE DEPT3
(
 DEPTID     CHAR(2),
 DEPTNAME   VARCHAR(20)
);
SELECT  COUNT(*) FROM DEPT3;
-- << 0개
INSERT INTO DEPT3
VALUES ('10','회계팀'); -- 1개

INSERT INTO DEPT3
VALUES ('20','인사팀'); -- 2개

COMMIT; -- 저장완료 시켜라

INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME, EMAIL, PHONE, HIRE_DATE, JOB_ID,
                      SALARY, BONUS_PCT, MARRIAGE, MGR_ID, DEPT_ID)
VALUES ('900','811122-1458712','오윤하','oyunha@kh.org','01011100001',DEFAULT,
        'J7',3000000,NULL,DEFAULT,'176','90');
SELECT  * FROM EMPLOYEE;
ROLLBACK;

-- COLUMN이름 생략되면, 테이블의 전체 행에 값을 기록해야한다.
-- COLUMN 개수 = 입력 값 개수, COLUMN 생성 순서 = 값 입력 순서
INSERT INTO EMPLOYEE
VALUES ('777','이병언','399000-1932930','bh@naver.com','01030290011',SYSDATE,'J4',4200000,NULL,DEFAULT,NULL,NULL);

-- SUB QUERY를 이용해서 INSERT하기.
CREATE TABLE EMP
(
 EMP_ID     CHAR(3),
 EMP_NAME   VARCHAR2(20),
 DEPT_NAME  VARCHAR2(20)
);

INSERT INTO EMP
(
 SELECT     EMP_ID, EMP_NAME, DEPT_NAME
 FROM       EMPLOYEE
 LEFT JOIN  DEPARTMENT USING (DEPT_ID)
);

SELECT  * FROM EMP;

ROLLBACK;