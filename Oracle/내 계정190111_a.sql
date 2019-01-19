-- DAY9 2019.01.11 -①
-- SQL-D를 위한 여러 함수들 (CF)
-- WITH 이름 AS (SUB QUERY)
-- SELECT * FROM 이름
-- SUB QUERY에 이름을 붙여주고, 사용시 이름을 사용한다.
-- 같은 쿼리문이 여러번 사용될 경우 유용하게 쓸 수 있음. → 중복 줄이기에 용이.
-- QUERY문을 일일히 직접 작성하는 것 보다 이름처리하는 것이 실행속도도 빠르다.
-- 주로 INLINE VIEW의 SUB QUERY에 많이 이용한다.

-- 부서별 급여의 합계가 전체 급여 총합의 20%보다 많이 가져가는 부서명과 부서의 급여합계를 조회함.
SELECT   DEPT_NAME, SUM(SALARY)
FROM     EMPLOYEE
NATURAL  JOIN  DEPARTMENT --→ DEPARTMENT의 기본 키와 조인됨.
GROUP BY DEPT_NAME
HAVING   SUM(SALARY) > ( SELECT SUM(SALARY) * 0.2
                         FROM   EMPLOYEE );

-- 위의 QUERY를 WITH구문을 사용한 SQL로 바꾸면
WITH    TOTAL_SAL AS ( SELECT   DEPT_NAME, SUM(SALARY) SSAL
                       FROM     EMPLOYEE
                       NATURAL  JOIN DEPARTMENT
                       GROUP BY DEPT_NAME )
SELECT  DEPT_NAME, SSAL -- WITH구문은 바로 이어서 SELECT문 작성해야함.
FROM    TOTAL_SAL -- INLINE VIEW
WHERE   SSAL > ( SELECT  SUM(SALARY) * 0.2
                 FROM    EMPLOYEE );
                 
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/*
 오라클 분석함수는 데이터를 분석하는 함수이다.
 분석함수를 사용하면, QUERY(SELECT)실행의 결과인 RESULT SET(결과집합)을 대상으로
 전체 데이터가 아닌 소그룹별로 각 행의 분석결과를 표현하는 함수.
 
 일반 그룹함수들과 다른 점 :
  분석함수는 분석함수용 그룹을 별도로 정의해서 각 그룹을 대상으로 한 분석계산을 수행함.
  일반 그룹함수는 그냥 그룹별 계산 수행
  
 <사용형식>
 
 SELECT 분석함수명 ([전달인자1, 전달인자2, 전달인자3])
          OVER([QUERY PARTITION 절],
               [ORDER BY 절],
               [WINDOW 절])
 FROM   테이블명
  
  ● 분석함수명 : AVG, SUM, RANK, MAX, MIN, COUNT 등
  ● 전달인자 : 분석함수에 따라서 0 ~ 3개까지 사용할 수 있음.
  ● QUERY PARTITION 절 : PARTIRION BY 표현식
                         PARTITION BY로 시작하며, 표현식에 따라서 그룹별로 분리하는 역할을 한다.
                         RESULT SET(결과집합)을 분리함.
  ● ORDER BY절 : ORDER BY COULMN DESC/ASC
                 ASC는 생략가능함.
                 PARTITION BY절 뒤에 위치하며, 계산 대항 그룹에 정렬작업을 수행한다.
                 분리된 소그룹 안에서 정렬처리 실행됨.
  ● WINDOW절 : 분석함수의 대상이 되는 데이터를 행(ROW)기준 범위, 즉 더 세부적으로 정의함.
               PARTITION BY에 의해 나누어진 그룹에 별도로 분석을 위한 소그룹을 만듦.
               PARTITION 안에서 일정 범위의 데이터를 분석 처리해라 -> 를 실행.
*/

-- ◆◆ 등수 부여하는 함수 : RANK ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- 같은 등수가 있을 때는 다음 등수값을 건너 뜀
-- 예 : 1, 2, 2, 4

-- 급여에 순위 부여하기
SELECT  EMP_ID, EMP_NAME, SALARY,
        RANK() OVER(ORDER BY SALARY DESC) 순위
FROM    EMPLOYEE;

-- RANK()안에 전달인자 사용하기.
-- 목적 : 어떤 값의 순위를 조회하고 싶을때.
-- RANK(순위를 알고 싶은 값)

-- 급여 2300000이 몇등일까?
-- CONDITION : 급여가 내림차순을 정렬 되었을때의 등수.
SELECT  RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) || '순위' AS 등수
FROM    EMPLOYEE;

-- ◆◆ DENSE_RANK() ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- 공동 순위가 있을 때 다음 순위를 생략하지 않음
-- 1, 2, 2, 3...
SELECT   EMP_ID, DEPT_ID, SALARY,
         RANK() OVER(ORDER BY SALARY DESC) "순위1",
         DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위2",
         DENSE_RANK() OVER(PARTITION BY DEPT_ID ORDER BY SALARY DESC) "순위3" --> 90코드 끼리의 순위...
FROM     EMPLOYEE
ORDER BY DEPT_ID DESC;

-- ◆◆ CUME_DIST() (CUMulative DISTribution) ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- PARTITION BY로 나눈 그룹 별로 각 행(ROW)을 ORDER BY절에 명시된 순서로 정렬한다.
-- 그리고 나서 그룹별로 누적된 분산정도(상대적인 위치)를 구하는 함수이다.
-- 분산정도(상대적인 위치)는 구하고자 하는 값보다 작거나 같은 값을 가진 행(ROW) 수를
-- 그룹 내의 행수로 나눈 것을 의미함. 0에서 1 사이의 값으로 표현됨.

-- 부서코드가 50인 직원의 이름, 급여, 누적분산 조회.
SELECT   EMP_NAME, SALARY,
         ROUND(CUME_DIST() OVER(ORDER BY SALARY), 1) 누적분산
FROM     EMPLOYEE
WHERE    DEPT_ID ='50';

-- ◆◆ NTILE() ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- PARTITION을 버킷(BUCKET)그룹별로 나누고, PARTITION 내의 각 행(ROW)을 
-- BUCKET에 배치하는 함수임.

-- 예를 들어 PARTITION안에 100개의 행이 있다고 가정했을 때, BUCKET을 4개로 설정한다면 1개의 BUCKET당
-- 25개의 행(ROW)이 배분된다.
-- 정확하게 분배되지 않을 때는 근사치로 배분한 후 남는 행은 최초 BUCKET에 할당됨.

-- 급여를 4개 등급으로 분류하기.
SELECT   EMP_NAME, SALARY,
         NTILE(4/*설정할 BUCKET의 개수*/) OVER(ORDER BY SALARY) 등급
FROM     EMPLOYEE;

-- ◆◆ ROW_NUMBER() ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- ROWNUM과는 관계가 없음
-- 각 PARTITION 내의 값들을 ORDER BY로 정렬한 후에 여기세 순번을 부여함.

-- 사번, 이름, 급여, 입사일, 순번
-- 단 순번은 급여가 많은 순으로, 급여가 같다면 보다 빨리 입사한 순으로.
SELECT   EMP_ID, EMP_NAME, SALARY, HIRE_DATE,
         ROW_NUMBER() OVER(ORDER BY SALARY DESC, HIRE_DATE ASC) 순번
FROM     EMPLOYEE;

-- 집계함수 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- EMPLOYEE 테이블로부터 부서코드가 '60'인 직원들의 사번, 급여, 해당 부서그룹(WINDOW)의 사번을
-- 오름차순으로 정렬.
SELECT   EMP_ID, SALARY,
         SUM(SALARY) OVER(PARTITION BY DEPT_ID
                          ORDER BY EMP_ID
                          ROWS BETWEEN UNBOUNDED PRECEDING 
                               AND UNBOUNDED FOLLOWING) "WIN1",
-- 첫 행부터 마지막 행까지의 급여합계를 구해서 'WIN1'에, 
/* THE FIRST WINDOW'S ROW : UNBOUNDED PRECEDING
   THE FINALLY WINDOW'S ROW : UNBOUNDED FOLLOWING */
         SUM(SALARY) OVER(PARTITION BY DEPT_ID
                          ORDER BY EMP_ID
                          ROWS BETWEEN UNBOUNDED PRECEDING 
                               AND CURRENT ROW) "WIN2",
-- WINDOW의 시작행부터 현재 위치(CURRENT ROW)까지의 합계를 구해서 'WIN2'에,
         SUM(SALARY) OVER(PARTITION BY DEPT_ID
                          ORDER BY EMP_ID
                          ROWS BETWEEN CURRENT ROW 
                               AND UNBOUNDED FOLLOWING) "WIN3"
-- CURRENT ROW에서 WINDOW의 마지막 행까지의 합계를 'WIN3' 조회.
FROM     EMPLOYEE
WHERE    DEPT_ID = '60';

----------------- 다르게 표현해봅시다.
SELECT   EMP_ID, SALARY,
         SUM(SALARY) OVER(PARTITION BY DEPT_ID
                          ORDER BY EMP_ID
                          ROWS BETWEEN 1 PRECEDING 
                               AND 1 FOLLOWING) "WIN1",
-- 급여의 합계를 현재행 중심으로 -1행, +1행까지 구해서 "WIN1" ▶ 1 PRECEDING AND 1 FOLLOWING

         SUM(SALARY) OVER(PARTITION BY DEPT_ID
                          ORDER BY EMP_ID
                          ROWS BETWEEN 1 PRECEDING 
                               AND CURRENT ROW) "WIN2",
-- WINDOW의 이전행과 현재위치(CURRENT ROW)까지의 합계를 구해서 "WIN2" ▶ 1 PRECEDING AND CURRENT ROW
         SUM(SALARY) OVER(PARTITION BY DEPT_ID
                          ORDER BY EMP_ID
                          ROWS BETWEEN CURRENT ROW 
                               AND 1 FOLLOWING) "WIN3"
-- CURRENT ROW에서 WINDOW의 다음 행까지의 합계를 'WIN3' 조회. ▶ CURRENT ROW AND 1 FOLLOWING
FROM     EMPLOYEE
WHERE    DEPT_ID = '60';

-- ◆◆ RATIO_TO_REPORT() ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- 해당구간에서 차지하는 비율을 리턴하는 함수

-- 직원들의 총급여를 2천만원 증가시킬 때, 기존 급여 비율을 적용해서 각 직원의 급여 인상분 조회
SELECT  EMP_NAME, SALARY,
        LPAD(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 100, 0), 5) || '%'급여비율,
        TO_CHAR(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 20000000, 0), 'L00,999,999')급여인상분
FROM    EMPLOYEE;

-- ◆◆ LAG(조회할 범위, 이전위치, 기준현재위치) OVER() ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- 지정하는 COLUMN의 현재 행(ROW)을 기준으로 이전 행(윗 행)의 값을 조회함
SELECT  EMP_NAME, DEPT_ID, SALARY,
        /* 1 : 바로 윗 행의 값, 0 : 이전 행이 없으면 0 처리 */
        LAG(SALARY, 1, 0) OVER(ORDER BY SALARY) "조회1",
        /* 이전 행이 없으면 현재 행의 값을 출력 */
        LAG(SALARY, 1, SALARY) OVER(ORDER BY SALARY) "조회2",
        /* 부서그룹 안에서의 이전 행 값 출력 */
        LAG(SALARY, 1, SALARY) OVER(PARTITION BY DEPT_ID
                                    ORDER BY SALARY) "조회3"
FROM    EMPLOYEE;

-- ◆◆ LEAD(조회할 범위, 다음 행 수, 0 또는 COLUMN) OVER() ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆ ◆◆◆◆
-- 다음 행의 값 조회할 때 사용함.
SELECT   EMP_NAME, DEPT_ID, SALARY,
        /* 1 : 바로 다음 행의 값, 0 : 다음 행이 없으면 0 처리 */
         LEAD(SALARY, 1, 0) OVER(ORDER BY SALARY) "조회1",
        /* 다음 행이 없으면 현재 행의 값을 출력 */
         LEAD(SALARY, 1, SALARY) OVER(ORDER BY SALARY) "조회2",
        /* 부서그룹 안에서의 다음 행 값 출력 */
         LEAD(SALARY, 1, SALARY) OVER(PARTITION BY DEPT_ID
                                      ORDER BY SALARY) "조회3"
FROM     EMPLOYEE
ORDER BY DEPT_ID;