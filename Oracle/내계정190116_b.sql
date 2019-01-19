-- DAY11 2019.01.16 -②
/*
-- ━━ VIEW ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 SELECT QUERY의 실행결과를 보여주는 화면.
 결과화면을 가상테이블로 저장하여 사용할 수 있음.
 마치 사진 찍어 사진을 보관하듯 결과화면도 이와같은 방식으로 보관하는 개념의 객체.
 
 < 사용 목적 > 
 → 보안에 유리 : 보관된 결과 화면만 보여줌으로써 전체 QUERY를 보이지 않음.
 → 복잡하고 긴 QUERY문을 매번 실행시키지 않아도 됨.

 < 사용 형식 >
 CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW VIEW이름
 AS (SUB QURRY)
 WITH CHECK OPTION CONSTRAINT 이름
 WITH READ ONLY CONSTRAINT;
 
 관리자계정에서 권한을 부여받아야 view를 만들 수 있다
 → grant create view to student;
*/

-- VIEW 만들기
-- 90번 부서에 소속된 직원 정보를 조회해서 뷰에 저장하기.
-- 이름, 부서명, 직급명, 급여
-- VIEW 'V_EMP_DEPT90'
CREATE VIEW   V_EMP_DEPT90
AS  SELECT    EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
    FROM      EMPLOYEE
    LEFT JOIN JOB USING (JOB_ID)
    LEFT JOIN DEPARTMENT USING (DEPT_ID)
    WHERE   DEPT_ID = '90';
    
-- 만든 VIEW 확인
SELECT  * FROM V_EMP_DEPT90;
-- 딕셔너리 확인 : USER_VIEWS, USER_OBJECTS, USER_CATALOG
DESC USER_VIEWS

SELECT  VIEW_NAME, TEXT_LENGTH, TEXT, READ_ONLY
FROM    USER_VIEWS;

-- VIEW는 수정할 수 없다. 덮어쓰기 방식으로 해야함.
-- ALTER VIEW (x)
-- OR REPLACE를 사용함.
-- CREATE OR REPLACE VIEW : VIEW가 없으면 새로 생성, 있으면 덮어쓰기.
CREATE OR REPLACE VIEW V_EMP_DEPT90
AS  SELECT      EMP_NAME, JOB_TITLE, SALARY
    FROM        EMPLOYEE
    LEFT JOIN   JOB USING (JOB_ID)
    LEFT JOIN   DEPARTMENT USING (DEPT_ID);
    
-- 실습
-- 직급이 '사원'인 직원들의 이름, 부서명, 직급명 조회하고 VIEW에 저장
-- V_EMP_DEPT_JOB
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS  SELECT      EMP_NAME, DEPT_NAME, JOB_TITLE
    FROM        EMPLOYEE
    LEFT JOIN   JOB USING (JOB_ID)
    LEFT JOIN   DEPARTMENT USING (DEPT_ID)
    WHERE       JOB_TITLE = '사원';
    
SELECT  * FROM V_EMP_DEPT_JOB;

-- VIEW는 데이터를 가지고 있지 않음 : 가상 테이블 (Virtual Table)
-- VIEW도 TABLE처럼 객체로 조회가능함
SELECT  COLUMN_NAME, DATA_TYPE, NULLABLE
FROM    USER_TAB_COLS
WHERE   TABLE_NAME = 'V_EMP_DEPT_JOB';

-- VIEW에서 ALIAS 사용하기.
-- 1. VIEW 이름 옆에 (ALIAS, ...), 단 전부 별칭붙여주어야함.
-- 2. SUB QUERY의 SELECT절에서 ALIAS사용, 선택적으로 별칭사용할 수 있음.
CREATE OR REPLACE VIEW V_EMP_DETP_JOB (ENM, DNM, TITLE)
AS  SELECT      EMP_NAME, DEPT_NAME, JOB_TITLE
    FROM        EMPLOYEE
    LEFT JOIN   JOB USING (JOB_ID)
    LEFT JOIN   DEPARTMENT USING (DEPT_ID)
    WHERE       JOB_TITLE = '사원';
    
SELECT   * FROM V_EMP_DETP_JOB;

-------------------------------------------------------
CREATE OR REPLACE VIEW V_EMP_DETP_JOB
AS  SELECT      EMP_NAME ENAME, DEPT_NAME DNAME, JOB_TITLE JTITLE
    FROM        EMPLOYEE
    LEFT JOIN   JOB USING (JOB_ID)
    LEFT JOIN   DEPARTMENT USING (DEPT_ID)
    WHERE       JOB_TITLE = '사원';
    
SELECT   * FROM V_EMP_DETP_JOB;

-- 반드시 별칭을 사용해야하는 경우
-- SUB QUERY의 SELECT절에 함수식 또는 계산식이 있을 때.

-- 직원들의 이름, 성별, 나이 조회
-- VIEW에 저장 - V_EMP
CREATE OR REPLACE VIEW V_EMP
AS  SELECT  EMP_NAME,
            DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 3, '남', '여') 성별,
            --ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12, 0)
            TO_CHAR(SYSDATE, 'YY')+100 - TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'), 'YY') 나이
    FROM    EMPLOYEE;  
    
SELECT  * FROM V_EMP;

-- 뷰 관련 제약조건
-- 뷰의 원래 목적은 아니지만, 뷰를 통한 DML 작업 가능함
-- DML 의 작업 결과는 베이스 테이블의 데이터에 적용됨
-- COMMIT / ROLLBACK 실행 필요함

-- 뷰를 통한 DML 작업은 여러가지 제한이 있음
-- 뷰 생성시에 DML 작업에 대한 제한을 설정할 수 있음
-- WITH READ ONLY : 읽기 전용 뷰, 뷰를 통한 DML 작업 불가
-- WITH CHECK OPTION : 뷰를 통한 DML 작업 가능함, 
--              뷰를 통해 접근 가능한 데이터에만 DML 수행할 수 있음

-- WITH READ ONLY
CREATE OR REPLACE VIEW V_EMP
AS
SELECT * FROM EMPLOYEE
WITH READ ONLY;

-- 확인
UPDATE V_EMP
SET PHONE = NULL;  -- ERROR

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO)
VALUES ('789', '오현정', '811122-1234567');  -- 에러

DELETE FROM V_EMP;  -- ERROR

SELECT * FROM V_EMP;

-- WITH CHECK OPTION
-- 조건에 따라 INSERT / UPDATE 작업 제한
-- DELETE는 제한 없음
CREATE OR REPLACE VIEW V_EMP
AS  SELECT  EMP_ID, EMP_NAME, EMP_NO, MARRIAGE
    FROM    EMPLOYEE
    WHERE   MARRIAGE = 'N'
    WITH CHECK OPTION;
    
-- 테스트
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
-- VALUES ('789','오현정','911122-1234544', 'Y'); >> ERROR
VALUES ('789','오현정','911122-1234544', 'Y');

SELECT  * FROM EMPLOYEE;

SELECT  * FROM V_EMP;

UPDATE V_EMP
SET MARRIAGE = 'Y'; -- ERROR

-- 뷰를 생성할 때 사용한 WHERE 조건에 작용되는 범위에서만 수정이 허용됨.
UPDATE V_EMP
SET EMP_ID = '000'
WHERE EMP_ID = '789';

SELECT  * FROM EMPLOYEE;
ROLLBACK;
-- VIEW 사용
-- 테이블을 대신해서 사용할 수 있음
-- FROM 뷰이름 : 인라인 뷰
CREATE OR REPLACE VIEW V_EMP_INFO
AS  SELECT      EMP_NAME, DEPT_NAME, JOB_TITLE
    FROM        EMPLOYEE
    LEFT JOIN   JOB USING (JOB_ID)
    LEFT JOIN   DEPARTMENT USING (DEPT_ID);
    
SELECT  * FROM V_EMP_INFO;
SELECT  EMP_NAME
FROM    V_EMP_INFO
WHERE   DEPT_NAME = '해외영업1팀'
        AND JOB_TITLE = '사원';
        
-- 뷰 삭제
-- DROP VIEW 뷰이름;
DROP VIEW V_EMP;

-- 뷰 옵션 : FORCE / NOFORCE
-- FORCE : SUB QUERY에서 사용된 테이블이 존재하지 않아도 뷰 생성됨
-- QUERY문만 저장하겠다는 의미
CREATE OR REPLACE FORCE VIEW V_EMP
AS  SELECT  TCODE, TNAME, TCONTENT
    FROM    TTT;
    -- 오류와 함께 생성됨 
-- FORCE 안쓰면 에러, NOFORCE에러(원칙은 노포체. 테이블이 있어야하는 것이기 때문에 없으니 에러)
CREATE OR REPLACE VIEW V_EMP
AS  SELECT  TCODE, TNAME, TCONTENT
    FROM    TTT;
    
    
-- INLINE VIEW
-- 일반적으로 FROM절에서 사용된 SUB QUERY에 별칭을 붙인 것
SELECT  EMP_NAME, SALARY
FROM    ( SELECT    NVL(DEPT_ID, '00') DID,
                    ROUND(AVG(SALARY), -3) DAVG
          FROM      EMPLOYEE
          GROUP BY  DEPT_ID ) ILNV
JOIN    EMPLOYEE ON (NVL(DEPT_ID, '00') = ILNV.DID)
WHERE   SALARY > ILNV.DAVG
ORDER BY 2 DESC;

-- 또는 뷰 생성하고 사용
CREATE OR REPLACE VIEW V_DEPT_SALAVG
AS  SELECT    NVL(DEPT_ID, '00') DID,
              ROUND(AVG(SALARY), -3) DAVG
    FROM      EMPLOYEE
    GROUP BY  DEPT_ID; 
    
-- 뷰 사용
SELECT  EMP_NAME, SALARY
FROM    EMPLOYEE
JOIN    V_DEPT_SALAVG ON (NVL(DEPT_ID, '00') = DID)
WHERE   SALARY > DAVG
ORDER BY 2 DESC;