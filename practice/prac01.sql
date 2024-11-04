--간단한 DB 쿼리 연습
SELECT *
FROM emp;

--emp 테이블 사전기준 이름순 정렬.
select *
FROM emp
ORDER by ename;

--emp 테이블 부서번호 별 정렬 + 급여가 높은 순서대로
select *
FROM emp
ORDER BY deptno, sal DESC;

--emp 급여가 2000이 넘는 사람들 중 급여가 높은 순서대로
SELECT *
from emp
WHERE sal >2000
ORDER by sal DESC;

--student 테이블 1학년을 제외하고, 나이가 어린순서대로
SELECT *
FROM student
WHERE grade <> 1 
ORDER BY birthday DESC;



