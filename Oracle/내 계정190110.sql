--DAY8 2019.01.10

/*
 다중행 SUBQUERY에 사용할 수 있는 연산자
 =ANY가 있는데 IN이랑 같은 연산자이고 둘 중 주로 IN을 사용한다.
 : IN/NOT IN, ANY, ALL
*/

-- COLUMN > ANY (다중행 SUB QUERY) : SUB QUERY값중, 최소값보다 큰가?
-- COLUMN < ANY (다중행 SUB QUERY) : SUB QUERY값중, 최대값보다 작은가?

-- 대리 직원 중, 과장 급여의 최소값보다 많이 받는 직원 조회
-- 과장 중 가장 적은 급여받는 사람보다 많이 받는 대리가 있는가?
SELECT   EMP_ID,
         EMP_NAME,
         JOB_TITLE,
         SALARY
FROM     EMPLOYEE
JOIN     JOB USING (JOB_ID)
WHERE    JOB_TITLE = '대리'
         AND SALARY > ANY ( SELECT  SALARY
                            FROM    EMPLOYEE
                            JOIN    JOB USING (JOB_ID)
                            WHERE   JOB_TITLE = '과장' );
                            
-- COLUMN > ALL (다중행 SUB QUERY) : COLUMN값 VS SUB QUERY값, 가장 큰 값보다 큰가?
-- COLUMN < ALL (다중행 SUB QUERY) : COLUMN값 VS SUB QUERY값, 가장 작은 값보다 작은가?

-- 과장 급여 중 가장 큰 값보다 급여를 많이 받는 대리 조회.
-- 급여가 가장 많은 과장보다 급여가 많은 대리 조회.
SELECT   EMP_ID,
         JOB_TITLE,
         SALARY
FROM     EMPLOYEE
JOIN     JOB USING (JOB_ID)
WHERE    JOB_TITLE = '대리'
         AND SALARY > ALL ( SELECT  SALARY
                            FROM    EMPLOYEE
                            JOIN    JOB USING (JOB_ID)
                            WHERE   JOB_TITLE = '과장' );

-- SUB QUERY 사용 위치
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, 
-- INSERT, UPDATE, CREATE TABLE, CREATE VIEW

-- 자기 직급의 평균 급여와 같은 급여를 받는 직원 조회.
-- CASE 1. WHERE절에서 SUB QUERY사용
SELECT    JOB_ID,
          TRUNC(AVG(SALARY), -5) "직급별 급여평균"
FROM      EMPLOYEE
GROUP BY  JOB_ID;

SELECT    EMP_NAME,
          JOB_TITLE,
          SALARY
FROM      EMPLOYEE E
LEFT JOIN JOB USING (JOB_ID)
WHERE     SALARY IN ( SELECT   TRUNC(AVG(SALARY), -5)
                      FROM     EMPLOYEE
                     -- WHERE   NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' ')
                      GROUP BY JOB_ID               );
                      
SELECT    EMP_NAME,
          JOB_TITLE,
          SALARY
FROM      EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE     SALARY IN ( SELECT   TRUNC(AVG(SALARY), -5)
                      FROM     EMPLOYEE
                      WHERE   NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' ')
                      GROUP BY JOB_ID               );
-- CASE 2. FROM절에서 SUB QUERY사용
-- FROM 테이블이름 >>>> FROM (SUB QUERY)
-- 테이블을 대신한다.
-- INLINE VIEW(인라인뷰) : FROM절에 사용된 SUB QUERY의 결과집합.
-- 별칭사용가능.
SELECT    EMP_NAME, JOB_TITLE, SALARY
FROM      ( SELECT  JOB_ID,
                    TRUNC(AVG(SALARY), -5) JOBAVG
            FROM    EMPLOYEE
            GROUP BY JOB_ID      ) V
LEFT JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY
                         AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY  3, 2;

/*
 CF>
 단일행 SUB QUERY
 다중행 SUB QUERY
 다중열 단일행 SUB QUERY : 결과값 → 항목은 여러 개 값은 1행
 다중열 다중열 SUB QUERY : 결과값 → 항목은 여러 개 값도 여러개.
 ▶▶▶ 대부분의 SUB QUERY는 SUB QUERY가 만든 값을 MAIN QUERY가 사용하는 구조.
 
 
 상호연관 SUB QUERY : SUB QUERY가 MAIN QUERY의 값을 이용해 결과를 냄.
                     MAIN QUERY의 값에 따라 SUB QUERY의 결과도 달라짐
 스칼라 SUB QUERY : 상관QUERY + 단일행 SUB QUERY
*/
-- CASE 3. 상[호연]관 SUB QUERY사용
-- GROUP BY와 비슷한 효과를 볼 수 있음.
SELECT    EMP_NAME,
          JOB_TITLE,
          SALARY
FROM      EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE     SALARY = ( SELECT  TRUNC(AVG(SALARY), -5)
                     FROM    EMPLOYEE
                     WHERE   NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' ') )
ORDER BY  2;

-- CASE 4. 다중열 다중행 SUB QUERY
SELECT    EMP_NAME,
          JOB_TITLE,
          SALARY
FROM      EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE     (NVL(JOB_ID, ' '), SALARY) 
          IN ( SELECT   NVL(JOB_ID, ' '),
                        TRUNC(AVG(SALARY), -5)
               FROM     EMPLOYEE
               GROUP BY NVL(JOB_ID, ' ')     )
ORDER BY  2;

-- EXISTS / NOT EXISTS 연산자
-- 상관QUERY에만 사용하는 연산자이다.
-- SUB QUERY의 결과가 존재하는지 / 존재하지 않는지 물어보는 연산자임.

-- 관리자인 직원 정보 조회
SELECT   EMP_ID,
         EMP_NAME, '관리자' 구분
FROM     EMPLOYEE E
WHERE    EXISTS ( SELECT  NULL
                  FROM    EMPLOYEE
                  WHERE   E.EMP_ID = MGR_ID );
-->> SUB QUERY의 조건을 만족하는 행들만 골라냄

-- 관리자가 아닌 직원 정보 조회
SELECT   EMP_ID,
         EMP_NAME, '직원' 구분
FROM     EMPLOYEE E
WHERE    NOT EXISTS ( SELECT  NULL
                      FROM    EMPLOYEE
                      WHERE   E.EMP_ID = MGR_ID );
                      
-- 스칼라 SUB QUERY
-- 하나의 COLUMN에서 1개의 행을 결과로 반환하는 상관QUERY
-- 상관QUERY + 단일행 SUB QUERY

-- 사원명, 부서코드, 급여, 해당 직원이 소속된 부서의 급여평균 조회
SELECT    EMP_NAME,
          DEPT_ID,
          SALARY,
          ( SELECT   TRUNC(AVG(SALARY), -5) -- 항목 1개 평균값 1개
            FROM     EMPLOYEE
            WHERE    DEPT_ID = E.DEPT_ID   ) AS "AVG SAL"
FROM      EMPLOYEE E;

-- CASE표현식에 SUB QUERY 사용한 경우.
-- 부서의 근무지역이 'OT'이면 '본사팀', 아니면 '지역팀'으로 직원 근무지역의 소속 조회
SELECT    EMP_ID,
          EMP_NAME,
          CASE WHEN DEPT_ID = ( SELECT  DEPT_ID
                                FROM    DEPARTMENT
                                WHERE   LOC_ID = 'OT' ) THEN '본사팀'
            ELSE '지역팀'
          END  AS 소속
FROM      EMPLOYEE
ORDER BY  소속 DESC;

-- ORDER BY절에 스칼라 SUB QUERY사용 가능
-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬되게 직원 정보 조회
SELECT   EMP_ID,
         EMP_NAME,
         DEPT_ID,
         HIRE_DATE
FROM     EMPLOYEE E
ORDER BY ( SELECT   DEPT_NAME
           FROM     DEPARTMENT
           WHERE    DEPT_ID = E.DEPT_ID ) DESC NULLS LAST;
           
-- TOP-N 분석
-- 상위 몇 개, 하위 몇 개를 조회할 때.

-- 인라인 뷰와 RANK() 함수를 이용한 TOP-N 분석의 예
-- 예 : 직원 정보에서 급여를 가장 많이 받는 직원 5명 조회.
SELECT   *
FROM     ( SELECT  EMP_NAME,
                   SALARY,
                   RANK() OVER(ORDER BY SALARY DESC) 순위
           FROM EMPLOYEE ) -- 인라인 뷰
WHERE    순위 <= 5;

-- ROWNUM을 이용한 TOP-N 분석
SELECT   ROWNUM, EMP_ID
FROM     EMPLOYEE
WHERE    SALARY > 3500000
ORDER BY EMP_NAME ASC;
--> ROWNUM(행번호)이 부여되는 시점은 SELECT할 때임.
-- ORDER BY 하면 행번호 변경 안되고 섞임.
-- 해결 : ORDER BY 한 다음에 ROWNUM이 부여되기 하려면 FROM절에 SUB QUERY를 사용함(인라인 뷰 이용)

-- 예 : 급여를 많이 받는 직원 3명 조회 (급여 조회)
SELECT   ROWNUM, EMP_NAME, SALARY
FROM     EMPLOYEE
WHERE    ROWNUM < 4
ORDER BY SALARY DESC;
--> 급여 내림차순 정렬 전에 ROWNUM이 부여됨 -> 실제 결과는 다르다. 이렇게 하면 안 됨.

-- 해결 : 정렬되고 나서 ROWNUM이 부여되게끔 하면 가능함.
-- 인라인뷰를 이용함
SELECT   ROWNUM, EMP_NAME, SALARY
FROM     ( SELECT   *
           FROM     EMPLOYEE
           ORDER BY SALARY DESC ) -- 정렬 후에 ROWNUM이 부여됨
WHERE    ROWNUM < 4;
