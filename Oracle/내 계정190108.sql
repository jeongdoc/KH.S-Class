-- DAY 7 2019.01.08

-- SET OPERATOR (집합 연산자)
-- UNION, UNION ALL, INTERSECT, MINUS
-- UNION, UNION ALL (합집합) : 여러 개의 SELECT 문의 결과를 하나로 합침
-- INTERSECT (교집합) : 여러 개의 SELECT 결과에서 공통된 행만 골라냄
-- MINUS (차집합) : 첫 번째 SELECT 결과에서 두 번째 SELECT 결과와 겹치는, 즉 일치하는 부분을 뺀 결과만 선택함.

SELECT   EMP_ID, ROLE_NAME
FROM     EMPLOYEE_ROLE
UNION /*ALL*/
SELECT   EMP_ID, ROLE_NAME
FROM     ROLE_HISTORY;
-->> UNION : 중복값이 하나만 선택됨. 25행 출력.
-->> UNION ALL : 중복도 다 선택됨. 26행 출력.

SELECT   EMP_ID, ROLE_NAME
FROM     EMPLOYEE_ROLE
INTERSECT
SELECT   EMP_ID, ROLE_NAME
FROM     ROLE_HISTORY;
--> INTERSECT : 교집합. 1행 출력.

SELECT   EMP_ID, ROLE_NAME
FROM     EMPLOYEE_ROLE
MINUS
SELECT   EMP_ID, ROLE_NAME
FROM     ROLE_HISTORY;
--> MINUS : 교집합을 제외한 결과 출력. 21행 출력.

-- SET 연산자 사용시 주의사항
-- SELECT 절 COLUMN의 개수가 같아야 함 : 안맞을 시엔 더미(DUMMY) COLUMN을 이용해서 맞춰줌.
-- SELECT 절의 각 항목별로 자료형이 같아야 한다.
SELECT   EMP_NAME, JOB_ID, HIRE_DATE
FROM     EMPLOYEE
WHERE    DEPT_ID = '20'
UNION
SELECT   DEPT_NAME, DEPT_ID, NULL
FROM     DEPARTMENT
WHERE    DEPT_ID = '20';
-->> 개수가 맞지 않아서 DUMMY를 사용하지 않으면 ERROR.

-- 50번 부서에 소속된 직원 중 관리자와 일반 직원을 따로 조회해서 하나로 합쳐라.
SELECT   *
FROM     EMPLOYEE
WHERE    DEPT_ID = '50'; -- 일단 직원 조회

SELECT   EMP_ID, EMP_NAME, '관리자' 구분
FROM     EMPLOYEE
WHERE    DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT   EMP_ID, EMP_NAME, '직원' 구분
FROM     EMPLOYEE
WHERE    DEPT_ID = '50' AND EMP_ID <> '141'
ORDER BY 3, 1;

SELECT   'SQL을 공부하고 있습니다' ANSWKD, 3 순서
FROM     DUAL
UNION
SELECT   '우리는 지금', 1
FROM     DUAL
SELECT   '아주 재미있게', 2
FROM     DUAL
-- ORDER BY 순서; >> ERROR. 하나만 사용된 별칭은 사용할 수 없다.
ORDER BY 2; -- 순번으로 정렬해주면 ERROR가 안 남.

-- 집합연산자와 JOIN의 관계
SELECT   EMP_ID, ROLE_NAME 직무명
FROM     EMPLOYEE_ROLE
INTERSECT -- 교집합
SELECT   EMP_ID, ROLE_NAME 직무명
FROM     ROLE_HISTORY;

-- JOIN구문에서 USING (EMP_ID, ROLE_NAME) 방식의 의미 :
-- 두 COLUMN의 값을 하나의 값으로 생각하고 일치하는 항목을 찾음. 
-- INTERSECT와 유사.
-- (104 SE) = (104 SE) : 같은 값 → JOIN에 포함됨
-- (104 SE-ANLY) != (104 SE) : 다른 값 → JOIN에서 제외됨.

-- 위의 QUERY를 JOIN구문으로 바꾸면 : 같은 결과가 나온다.
SELECT   EMP_ID, ROLE_NAME
FROM     EMPLOYEE_ROLE
JOIN     ROLE_HISTORY USING ( EMP_ID, ROLE_NAME );

-- 집합연산자와 IN연산자의 관계
-- UNION과 IN이 동일한 결과를 낼 수 있음.

-- 직급이 대리 또는 사원인 직원의 이름과 직급명 조회
-- 직급순 오름차순정렬하고, 직급이 같으면 이름순 오름차순 정렬 처리함
SELECT   EMP_NAME, JOB_TITLE
FROM     EMPLOYEE
JOIN     JOB USING ( JOB_ID )
WHERE    JOB_TITLE IN ( '대리', '사원' )
ORDER BY 2, 1;

SELECT   EMP_NAME, JOB_TITLE
FROM     EMPLOYEE
JOIN     JOB USING ( JOB_ID )
WHERE    JOB_TITLE = '대리'
UNION
SELECT   EMP_NAME, JOB_TITLE
FROM     EMPLOYEE
JOIN     JOB USING ( JOB_ID )
WHERE    JOB_TITLE = '사원'
ORDER BY 2, 1;

-- ━━ SUB QUERY ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/*
 METHOD(리턴값이 있는 METHOD())
 COLUMN 비교연산자 비교값 ← 비교할 값을 알아내기 위한 SELECT문을 값의 자리에 작성
 
 COLUMN 비교연산자 (SELECT ···)
*/

-- SUB QUERY 서브쿼리
-- 쿼리문 안에 사용된 쿼리문
-- EG. 나승원이라는 직원과 같은 부서인 직원명단 조회
-- 1. 나승원직원이 소속된 부서 조회.
SELECT   DEPT_ID --> 50
FROM     EMPLOYEE
WHERE    EMP_NAME = '나승원';

-- 2. 1번에서 조회한 결과값을 사용해서 부서원들 조회
SELECT   EMP_NAME 이름 --> 6명
FROM     EMPLOYEE
WHERE    DEPT_ID = '50';

-- IF, SUB QUERY 사용
SELECT   EMP_NAME
FROM     EMPLOYEE
WHERE    DEPT_ID = ( SELECT DEPT_ID
                     FROM   EMPLOYEE
                     WHERE  EMP_NAME = '나승원' );
                     -- ▶ 하나의 값을 리턴 : 단일 행 서브쿼리

-- SUB QUERY의 유형은 단일행, 다중행, 다중열 다중행, 상호연관 그리고 스칼라가 있다.
-- SUB QUERY앞에 붙는 연산자가 각기 다르다.

/* 1. 단일행 SUB QUERY (Single Row SUB QUERY)
    → QUERY의 결과 값이 1개.
    → 일반 비교연산자 모두 사용할 수 있다. - <, >, <=, >=, =, ( != <> ^= )
*/
-- EG. 나승원과 직급이 같고, 나승원보다 급여를 많이 받는 직원 조회
--     이름, 직급, 급여 조회
-- 1. 나승원의 직급 조회
SELECT   JOB_ID -- J5
FROM     EMPLOYEE
WHERE    EMP_NAME = '나승원';

-- 2. 나승원의 급여 조회
SELECT   SALARY -- 2300000
FROM     EMPLOYEE
WHERE    EMP_NAME = '나승원';

-- 3. 결과 조회
SELECT   EMP_NAME, JOB_ID, SALARY
FROM     EMPLOYEE
WHERE    JOB_ID = 'J5' AND SALARY > 2300000;

-- TO SUB QUERY
SELECT   EMP_NAME, JOB_ID, SALARY
FROM     EMPLOYEE
WHERE    JOB_ID = ( SELECT  JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원' )
    AND  SALARY > ( SELECT  SALARY
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원');
                    
-- 최저급여 받고 있는 직원들 조회
SELECT   EMP_NAME 이름, 
         SALARY 급여
FROM     EMPLOYEE
WHERE    SALARY = ( SELECT  MIN(SALARY)
                    FROM    EMPLOYEE );
                    
-- 부서별 급여합계 중 가장 큰 값 조회
-- 가장 많은 급여를 받아가는 부서 조회
SELECT    DEPT_NAME, SUM(SALARY)
FROM      EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY  DEPT_NAME
HAVING    SUM(SALARY) = ( SELECT   MAX(SUM(SALARY))
                          FROM     EMPLOYEE
                          GROUP BY DEPT_ID );
                          
-- SUB QUERY는 SELECT절, FROM절, WHERE절, GROUP BY절, HAVING절, ORDER BY절에서 모두 사용할 수 있음.

/*
 2. 다중행 서브쿼리 (Multiple Row)
  → SUB QUERY 결과값이 여러개인 경우
  → 사용할 수 있는 연산자 
     ┌ COLUMN 'IN' : 여러 개의 값 중에서 한 개라도 일치하는 값이 있는가?
     ├ COLUMN 'NOT IN' : 여러 개의 값 중에서 단 한 개라도 일치하지 않는가?
     ├ COLUMN '> ANY' : 값들 중 비교값보다 하나라도 큰 값이 있는가? (가장 작은 값보다 큰가?)
     ├ COLUMN '< ANY' : 값들 중 비교값보다 하나라도 작은 값이 있는가? (가장 큰 값보다 작은가?)
     ├ COLUMN '> ALL' : 모든 값보다 큰가? (가장 큰 값보다 큰가?)
     └ COLUMN '< ALL' : 모든 값보다 작은가? (가장 작은 값보다 작은가?)
*/
-- EG. 부서별 급여 최저값 조회
SELECT   MIN(SALARY)
FROM     EMPLOYEE
GROUP BY DEPT_ID;

-- 부서별로 그 부서의 최저급여를 받고 있는 직원 조회
/*SELECT   EMP_ID, SALARY
FROM     EMPLOYEE
WHERE    SALARY = ( SELECT   MIN(SALARY)
                    FROM     EMPLOYEE
                    GROUP BY DEPT_ID ); -- 다중행 서브쿼리, ERROR */

-- 다중행 SUB QUERY에는 일반 비교연산자 사용할 수 없다.
-- 일반 비교연산자는 한 개의 값으로 비교판단하기 때문에 값이 여러개인 다중행은 안 됨.
-- '=' -> 'IN'
SELECT   EMP_ID, DEPT_ID, SALARY
FROM     EMPLOYEE
WHERE    SALARY IN ( SELECT   MIN(SALARY)
                     FROM     EMPLOYEE
                     GROUP BY DEPT_ID );
                     
-- IN / NOT IN : NOT IN 연산자는 NULL이 존재하면 안된다.
SELECT   DISTINCT MGR_ID -- 15개 (중복카운트), 6개(중복X)
FROM     EMPLOYEE
WHERE    MGR_ID IS NOT NULL;

-- 직원 정보에서 관리자만 추출하기
SELECT   EMP_ID, EMP_NAME, '관리자' 구분
FROM     EMPLOYEE
WHERE    EMP_ID IN ( SELECT   MGR_ID
                     FROM     EMPLOYEE )
UNION                   
SELECT   EMP_ID, EMP_NAME, '직원' 구분
FROM     EMPLOYEE
WHERE    EMP_ID NOT IN ( SELECT  MGR_ID
                         FROM    EMPLOYEE
                         WHERE   MGR_ID IS NOT NULL )
ORDER BY 3, 1;

-- SELECT절에서도 SUB QUERY사용할 수 있음
SELECT   EMP_ID, EMP_NAME,
         CASE WHEN EMP_ID IN ( SELECT MGR_ID  FROM EMPLOYEE ) THEN '관리자'
                ELSE '직원'
         END 구분
FROM     EMPLOYEE
ORDER BY 3, 1;