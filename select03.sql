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

/*
SELECT...
FROM...
WHERE...
GROUP BY
ORDER BY
*/

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


