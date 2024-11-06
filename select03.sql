--복수행 함수

COUNT(대상) 갯수

SELECT COUNT(*)  
FROM emp;

-- COUNT(*)한 행의 갯수가 나옴 

SELECT COUNT(empno), COUNT(*)  
FROM emp;
--직계함수만 가능하다
--null은 갯수로 쳐주지 않는다
SELECT COUNT(job), COUNT(mgr) , COUNT(hiredate), COUNT(comm) 
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE comm IS NOT NULL;

SELECT SUM(sal), COUNT(*)
FROM emp;

--10번, 20번 부서 다니는 애들 총 몇명? 총 급여 얼마?
SELECT COUNT(*), SUM(sal)
FROM emp
WHERE deptno IN (10,20);

SELECT 
    AVG(height), 
    MAX(height), 
    MIN(height), 
    STDDEV(height), 
    VARIANCE(height)
    /*
    height,
    NVL(height,130) */
FROM student;

--student 평균 키!
--전체 평균키 X , 각 학년별 평균키! 

SELECT '1학년' 학년, AVG(height) 평균키
FROM student
WHERE grade=1
UNION ALL
SELECT '2학년', AVG(height)
FROM student
WHERE grade=2
UNION ALL
SELECT '3학년', AVG(height)
FROM student
WHERE grade=3
UNION ALL
SELECT '4학년', AVG(height)
FROM student
WHERE grade=4;



--GROUP BY 특정 컬럼을 기준으로 그룹지어서 계산
--GROUP BY에 명시된 컬럼은 같이 조회 가능
SELECT grade, avg(height)
FROM student
GROUP BY grade;

--그룹을 지을수 있는경우에만 가능하다

SELECT studno, avg(height)
FROM student
GROUP BY grade;

SELECT grade, avg(height) height
FROM student
WHERE grade IN (1,2,3)
GROUP BY grade
ORDER BY height;
--ORDER BY grade desc;

/*
SELECT...
FROM...
WHERE...
GROUP BY
HAVING
ORDER BY
*/

SELECT 
    deptno
    ,AVG(sal)
FROM emp
--WHERE sal >= 2000  -- 평균급여가 2000이상인
GROUP BY deptno
HAVING AVG(sal) >= 2000
;
--WHERE 복수함수는 쓸수 없다 그래서 HAVING가 있다

--1) 급여가 1500 이상인 직원들만 대상으로 , 부서별 평균 급여

SELECT 
    deptno
    ,AVG(sal)
FROM emp
WHERE sal >= 1500
GROUP BY deptno
;

--2) 부서별 평균 급여가 1500 이상인경우만, 부서별 평균 급여 보여주기
SELECT 
    deptno
    ,AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 1500
;

--student 각 학년별 평균 몸무게
--평균 몸무게 65키로 이상인 경우만 확인
SELECT
    grade,
    AVG(weight)
FROM student
GROUP BY grade
HAVING AVG(weight) >= 65
;

--student 4학년을 제외하고
--각 학년별 평균 몸무게
--평균 몸무게 65키로 이상인 경우만 확인

SELECT
    grade,
    AVG(weight)
FROM student
WHERE grade <> 4   --4학년 제외
GROUP BY grade
HAVING AVG(weight) >= 65
;


SELECT 
    deptno
    ,job
    ,ROUND(AVG(sal), 1)
FROM emp
GROUP BY deptno
;

SELECT 
    deptno
    ,job
    ,ROUND(AVG(sal), 1)
FROM emp
GROUP BY ROLLUP(deptno, job)
;

-- CUBE 함수 - 소계와 전체 합계까지 출력하는 함수
SELECT 
    deptno
    ,job
    ,ROUND(AVG(sal), 1)
FROM emp
GROUP BY CUBE(deptno, job)
;

SELECT *
FROM emp
WHERE job = 'SALESMAN' and deptno = 30;


GROUP BY ROLLUP(deptno, job);
--1) deptno, jpb 그룹화
--2) deptno 그룹화 계
--3) () 그룹화 계

SELECT
    deptno
    ,job
    ,ROUND(AVG(sal),1)
FROM emp     
GROUP BY ROLLUP( (deptno, job ) );
--1) deptno, jpb 그룹화
--2) () 그룹화 계

GROUP BY ROLLUP(deptno, job, mgr);
--1) deptno, job, mgr 그룹
--2) deptno, job 계
--3) deptno 계
--4) () 계

SELECT
    deptno
    ,job
    ,mgr
    ,ROUND(AVG(sal), 1)
FROM emp    
GROUP BY ROLLUP(deptno, job, mgr);

-- RANK DENSE RANK
-- RANK 함수 – 순위 출력 함수 - 특정 데이터의 순위 확인하기:

--순위 RANK() OVER (ORDER BY 정렬기준)
--그룹단위 순위 RANK() OVER (PARTITION BY 기준 ORDER BY 정렬기준)

--RANK() OVER (ORDER BY sal desc)
--내림차순으로 순위값을 보여달라
SELECT
    ename
    ,sal
    ,RANK() OVER (ORDER BY sal desc)
    ,DENSE_RANK () OVER (ORDER BY sal desc)
FROM emp
;
--ORDER BY sal;

SELECT 
    name
    ,height
    ,RANK() OVER (ORDER BY height desc) 순위1
    ,DENSE_RANK() OVER (ORDER BY height desc) 순위2
    ,grade
    ,RANK() OVER (PARTITION BY grade ORDER BY height desc) 순위3
    ,DENSE_RANK() OVER (PARTITION BY grade ORDER BY height desc) 순위4
FROM student
ORDER BY grade, height DESC
;











