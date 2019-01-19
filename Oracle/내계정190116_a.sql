-- DAY11 2019.01.16 -①
/*
-- ━━ DELETE문 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 : 행을 삭제하는 구문
 
 DELTE [FROM] 테이블이름
 WHERE 조건식;
*/
-- WHERE절을 사용하지 않으면 테이블의 모든 행이 삭제된다.
SELECT  * FROM DCOPY;

DELETE FROM DCOPY;
-- 테이블은 그대로, 행만 전부 삭제.
ROLLBACK;
-- >> DELETE복구 가능. COMMIT해준거면 안됨.
-- 다른테이블에서 FOREIGN KEY로 참조되고 있는 테이블일 경우 행(ROW)삭제할 수 없다.
DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90'; -- ERROR 「integrity constraint violated - child record found」
-- 사용(참조)되고 있는 값이 기록된 행은 삭제할 수 없음을 알 수 있다.

-- 참조테이블이어도 값이 사용되지 않았다면 삭제할 수 있다.
DELETE FROM DEPARTMENT
WHERE DEPT_ID = '30'; -- > PASS

SELECT  * FROM DEPARTMENT;
/*
-- ━━ TRUNCATE문 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 : TABLE의 모든 행 삭제시 사용함. DELETE보다 빨리 삭제한다.
 : But, 복구할 수 없고 제약조건이 있다면 삭제할 수 없다. (ROLLBACK불가능)
*/
TRUNCATE TABLE DCOPY;
-- "Table DCOPY이(가) 잘렸습니다."
SELECT  * FROM DCOPY;
ROLLBACK; -->> CAN'T

TRUNCATE TABLE DEPARTMENT; -- ERROR 「unique/primary keys in table referenced by enabled foreign keys」

-- ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
-- ━━ TRANSACTION ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/*
 TCL (Transaction Controll Language) : 트랜젝션 관리 언어
 COMMIT, ROLLBACK, SAVEPOINT
*/
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINTS FK_MGRID;
-- → DDL 구문 실행 : 새 트랜잭션 시작
SAVEPOINT S0;
INSERT INTO DEPARTMENT
VALUES ('40','기획전략팀','A1');
SAVEPOINT S1;
UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL;
SAVEPOINT S2;
DELETE FROM EMPLOYEE;

ROLLBACK TO S2;

SELECT  * FROM EMPLOYEE;
--SELECT  CONSTRAINT_NAME, TABLE_NAME
--FROM    USER_CONSTRAINTS
--WHERE   CONSTRAINT_NAME = 'SYS_C007194';
--
--DROP TABLE TESTFK CASCADE CONSTRAINTS;

SELECT  COUNT(*)
FROM    EMPLOYEE
WHERE   DEPT_ID = '40';

ROLLBACK TO S0; -- COUNT(*)하면 0개.

-- 동시성 제어 : 잠금 (LOCK)
SELECT  EMP_ID, MARRIAGE
FROM    EMPLOYEE
WHERE   EMP_ID = '143';

UPDATE  EMPLOYEE
SET     MARRIAGE = 'Y'
WHERE   EMP_ID = '143';

COMMIT;
-- 다른 DEVELOPER을 켰을때 COMMIT전까지는 각자의 설정으로 출력된다.
-- COMMIT을 해주어야 동기화돼서 같은 결과 나옴.