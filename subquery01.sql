--subquery

select *
from emp;

-- 사번이 7844인 사원과 같은 부서 사람들 조회

select *
from emp
where deptno = (사번이 7844인 사원 조회)
;

select *
from emp
where deptno = (select deptno
                from emp
                where empno= 7844
                )
;

select *
from emp
where empno= 7844
;

/*
(1) 다중 행 Sub Query 예 1:
Emp2 테이블과 Dept2 테이블을 참조하여 근무지역(dept2 테이블의 area 컬럼)이
'Pohang Main Office' 인 모든 사원들의 사번과 이름, 부서번호를 출력하세요.

1.근무지역(dept2 테이블의 area 컬럼)이'Pohang Main Office' 인 모든 사원

*/
SELECT * FROM emp2;

SELECT * FROM dept2;

SELECT
* 
FROM dept2
WHERE area = 'Pohang Main Office'
;

SELECT * 
FROM emp2
WHERE deptno IN (SELECT
                    dcode 
                FROM dept2
                WHERE area = 'Pohang Main Office')
                -- IN(0001, 1003, 1006, 1007)
;

-- & 입력받아 처리하겠다 변수자체를 입력
-- : 입력받아 처리하겠다 바인드입력

SELECT * 
FROM emp2
WHERE deptno = :dno
;


SELECT * 
FROM emp2
WHERE deptno IN (SELECT 
                    dcode 
                FROM dept2
                WHERE area = 'Pohang Main Office')
                -- IN(0001, 1003, 1006, 1007)
;

-- Exists로 변환
-- 존재하느냐
SELECT * 
FROM emp2
WHERE EXISTS (SELECT
                    dcode 
                FROM dept2
                WHERE area = 'Pohang Main Office'
                AND dcode = deptno)
;

SELECT dcode 
FROM dept2
WHERE area = 'Pohang Main Office'
AND dcode= 1003
;


--다중컬럼
--Student테이블을 조회하여 전체 학생 중에서 체중이 2학년 학생들의 체중에서 가장 적게 나가는 학생보다
--몸무게가 적은 학생의 이름과 학년 몸무게를 출력하세요.
SELECT 
    name
    ,grade
    ,weight
FROM student
WHERE (grade, weight) IN (SELECT grade, MAX(weight) 
                            FROM student
                            GROUP BY grade) 
;

SELECT MAX(weight) 
FROM student
GROUP BY grade
;

/*
Emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는
직원의 이름과 직급, 연봉을 출력하세요.
연봉순으로 오름차순 정렬하세요.
*/

SELECT * 
FROM emp2 e1
WHERE pay >= (SELECT AVG(pay) 
                FROM emp2 e2
                WHERE e2.position = e1.position)
;

SELECT AVG(pay) 
FROM emp2
WHERE position = 'Department head'
;

/*
1) Scalar Sub Query 란?
예) Emp2 테이블과 dept2 테이블을 조회하여 사원들의 이름과 부서이름을 출력하
세요.
*/


SELECT * FROM emp2;

SELECT * FROM dept2;

--join
SELECT e.name, d.dname 
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
;

--subpuery
SELECT dname 
FROM dept2
WHERE dcode = 1006
;

select
    name,
    (SELECT dname
     FROM dept2
     WHERE dcode = deptno) dname
    -- WHERE dcode > deptno) dname 다중행 결과를 만들어서 안됨 "결과가 하나여야 함"
FROM emp2
;

--서브쿼리의 인라인개념

SELECT dname
     FROM dept2
     WHERE dcode = 1009
;


SELECT empno, ename, job, '직원' 
FROM emp
;

SELECT empno, ename, job, mgr, sal, comm, deptno
FROM emp
;

SELECT 
    sal
    ,mgr
FROM (SELECT empno, ename, job, mgr, sal, comm, deptno
FROM emp)
;

/*
emp 테이블과 dept 테이블을 조회하여
부서 번호와 부서별 최대 급여 및 부서명을
출력하세요.
*/

-- group by 집계 -> join
SELECT 
    e.deptno
    ,e.max_sal
    ,d.dname 
FROM (SELECT 
            deptno
            ,MAX(sal) max_sal 
        FROM emp
        GROUP BY deptno) e, dept d
WHERE e.deptno = d.deptno        
;

--join -> group by

SELECT deptno, MAX(sal), dname 
FROM (SELECT e.sal, e.deptno, d.dname
        FROM emp e, dept d
        WHERE e.deptno = d.deptno)
GROUP BY deptno, dname
;


