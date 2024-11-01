/*
1. 조회 SELECT

SELECT 조회 대상 컬럼명 FROM 테이블명;

SELECT * FROM dept;
* : 전체 ALL

테이블 구조 확인 (Describle)
DESC 테이블명

조회 데이터 리터럴 활용!
SELECT '문자', 3019 FROM 테이블명;

컬럼명을 별도로 지정하기 (컬럼별칭)
SELECT 컬럼명 AS "컬럼별칭",
        컬럼명 "컬럼별칭",
        컬럼명 컬럼별칭
FROM 테이블명;




*/


SELECT * FROM dept; -- dept테이블에 있는 모든 컬럼을 조회

select * from dept2; -- dept2print_table테이블에 있는 모든 컬럼을 조회

select * from emp;

select mgr, sal from emp;

--가독성
SELECT *
FROM emp;

SELECT
    EMPNO,
    ENAME,
    JOB
FROM emp;    

DESC emp; --emp 테이블 구조를 보여달라

SELECT empno, ename, '그냥문자', 999 FROM emp;  -- 리터럴값을 넣어서 입력하겠다
                                               -- 실제 테이블의 행의 갯수만큼 나온다

SELECT empno, ename, '그냥''문자''', 999 FROM emp;
-- 작은따옴표를 두개 붙이면 작은따옴표 표현가능

SELECT ename AS "이름",
       empno "사번", -- 컬럼에대한 별칭을 넣겠다는 의미
       job 직업,
       '그냥문자' 중요한의미, -- 컬럼에 대한 별칭을 지을때 작은따옴표 쓴다
       sal "직원의 월급"
FROM emp;

/*
중복값을 제거
DISTINCT
*/

select * from emp;

select DISTINCT job  --job 중복제거 조회
FROM emp;

select DISTINCT deptno --deptno 부서번호 중복제거 조회
FROM emp;

select DISTINCT (deptno) --deptno 부서번호 중복제거 조회
FROM emp;

select DISTINCT deptno, job --deptno 부서번호 여러개를 중복제거 조회 
FROM emp;                   -- 두개를 조합을 했을때 중복되는게 없을때 조회
                            -- 두개 조합 중복 제거(겹치는 것들이 사라짐)

-- 중복제거시 날아가니 잘 확인해야함
-- 가로 세로가 일치해야함

-- || 연결연산자

SELECT '나는' || '배가고프다' FROM dept;

SELECT DEPTNO || DNAME AS "부서번호이름",
       DEPTNO || DNAME "부서번호이름",
       DEPTNO || DNAME 부서번호이름
FROM dept;

SELECT deptno+10,
       deptno+20,
       deptno+30
FROM dept;

SELECT deptno+deptno+deptno
FROM dept;

SELECT * from student;

-- || 연결연산자

SELECT name ||'''s ID : '||id||', WEIGHT is '|| weight || 'Kg' AS "ID AND WEIGHT"
FROM student;

SELECT * from emp;

SELECT ename|| '(' || job || '), '|| ename || '''' || job || ''''  AS "NAME AND JOB"
FROM emp;

SELECT ename ||'''s sal is $'||sal AS "Name and Sal"
FROM emp;

/*
-- 원하는 조건만 골라내기 WHERE조건
찾고 싶은 조건 (결과 필터링)
SELECT ...
FROM ...
WHERE ...
*/

select * from emp; -- comm 성과급 지급 조건
-- null은 받을 수 있는 직업이 아니다 
-- 0은 받을 수 있는데 열심히 안해서 0임

SELECT *
FROM emp
WHERE comm is null; -- 성과급을 받지 않는 사람만

SELECT *
FROM emp
WHERE comm is not null; -- 성과급 지급 대상인 사람들만 보여줘

SELECT DISTINCT deptno from emp;

-- 부서번호 20번 부서에 속한 사람들만 보기
SELECT *
from emp
WHERE deptno = 20;

-- 부서번호 20번 부서에 속한 사람들의 이름과 급여 보기
SELECT ename, sal, deptno
from emp
WHERE deptno = 20;

--emp 테이블 급여 2000보다 적게 받는 사람들 목록
SELECT *
from emp
WHERE sal <2000;

--emp 테이블 직업이 CLERK 인 사람들만 취합
SELECT *
from emp
WHERE job = 'CLERK'; -- 실제 데이터가 대문자면 대문자로 써줌

--emp 테이블 직업이 CLERK이 아닌 사람들만 취합
SELECT *
from emp
WHERE job != 'CLERK'; 

SELECT *
from emp
WHERE job <> 'CLERK'; 

-- null만 유의해서 사용하면 된다

-- AND 연산자 BETWEEN
--emp 테이블 급여가 2000~3000인 사람들만 조회
SELECT *
from emp
--WHERE sal >= 2000 AND sal <= 3000;
WHERE sal BETWEEN 2000 AND 3000; -- 쿼리 만들때 속도가 빠르기때문에 이걸로 사용


-- student 테이블에서 1학년 3학년만 조회 (1학년이거나 3학년이거나~)
SELECT *
from student
--WHERE grade = 1 OR grade = 3;
WHERE grade IN (1,3);

-- student 테이블에서 1학년 3학년만 제외하고 조회 (1학년이거나 3학년이 아니거나~)
SELECT *
from student
-- WHERE grade IN (2,4);
WHERE grade <> 1 AND grade != 3; -- 1학년도 아니면서 3학년도 아님을 조회

/*
LIKE 패턴 검색
    LIKE
        % _
        %: 아무거나 아무갯수 0~N개
        _: 그 위치에 한개
*/        
SELECT * 
from emp
where ename LIKE '%MI%'; -- MI가 포함된 것을 모두 조회
--where ename LIKE 'MI%'; -- MI으로 시작하는 모든것 조회 
--where ename LIKE 'M%'; -- M으로 시작하는 모든것 조회 
-- where ename =  'WARD';

SELECT * 
from emp
--where ename LIKE '_MI';       -- 3글자인데 두번째 세번째에 MI가 들어가야함
--where ename LIKE '_MI__';     -- 5글자인데 두번째 세번째에 MI가 들어가야함 
where ename LIKE '_MI%';    -- n개~글자수 2~3번째가 MI

--< <= > >=

select *
FROM emp
WHERE hiredate < '1981-05-01'; --과거일수록 작고 미래일수록 크다
--WHERE hiredate = '81/05/01';

SELECT *
FROM student;

/*
정렬 ORDER BY
*정렬을 사용하지 않으면 순서보장 안됨
ORDER BY 정렬할 기준이되는 컬럼명 [ASC|DESC] [오름차순|내림차순] 오름차순이 기본
ASC는 기본 오름차순이라 생략가능

SELECT...
FROM...
WHERE...
ORDER BY...

SELECT...
FROM...
ORDER BY...

*/

SELECT * 
from student
--ORDER BY name; --name 기준 오름차순정렬
ORDER BY name DESC;     --name 기준 내림차순정렬

SELECT * 
from student
ORDER BY grade DESC;    -- 학년기준 내림차순

SELECT * 
from student
ORDER BY birthday;      --생일기준 오름차순

SELECT * 
from student
ORDER BY birthday DESC; --생일기준 내림차순 (큰수-> 작은수 방향)
                        --날짜에서 큰수는? 더큰 최근/미래 작은수? 더 과거

-- 정렬을 두개 걸어줄수 있음
SELECT *
FROM student
WHERE grade IN (1,2,3)  --학년 1,2,3학년만 조회
ORDER BY grade,height;  --학년 오름차순 정렬
                        --학년을 먼저 정리하고 그학년중에서 키순으로 정리하겠다

SELECT *
FROM student
WHERE grade IN (1,2,3)          --학년 1,2,3학년만 조회
ORDER BY grade,height DESC;     --height DESC만 내림차순, 각각 다 DESC를 넣어줘야함

/*

집합연산자
UNION 합집합 (중복제거)
UNION ALL 합집합 (중복제거X)
INTERSECT  교집합
MINUS 차집합

*/

--학생들 중에 101번학과 학생들과 102번학과 학생들 조회

SELECT *
from student
WHERE deptno1 IN (101, 102);

SELECT *
from student
WHERE deptno1 = 101
UNION ALL
SELECT *
from student
WHERE deptno2 = 102;

-- 갯수가 같아야 하고 타입의 순서도 같이 맞춰줘야함
-- 공백이 생기지 않게 리터럴값이라도 입력해줘야함
-- 각테이블 조회 결과 갯수/타입이 일치하는 형태로 만들어서 결합
SELECT studno, name, deptno1    --숫자 / 문자 / 숫자  3개                                 
from student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, 0     -- 숫자/문자/숫자(인위적으로 숫자형태 갯수 맞추기) 3개                              
from student
WHERE deptno2 = 101;

SELECT 
    studno idno, 
    name, 
    deptno1 "deptno",
    null AS "email"    --숫자 / 문자 / 숫자  3개                                 
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT 
    profno,
    name,
    deptno,
    email     -- 숫자/문자/숫자/문자  4개                       
FROM professor
WHERE deptno = 101;

SELECT studno, name, deptno1, 1 divtype    --숫자 / 문자 / 숫자  3개                                 
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno, 2     -- 숫자/문자/숫자(인위적으로 숫자형태 갯수 맞추기) 3개                              
FROM professor
WHERE deptno = 101;

SELECT studno, name, deptno1, '학생' divtype    --숫자 / 문자 / 숫자  3개                                 
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno, '교수'     -- 숫자/문자/숫자(인위적으로 숫자형태 갯수 맞추기) 3개                              
FROM professor
WHERE deptno = 101;

--교집합
SELECT *
FROM student
WHERE deptno1 = 101
INTERSECT  --최적화를 필요로 할때 쓰면 좋음
SELECT *
FROM student
WHERE deptno2 = 201;

SELECT *
FROM student
WHERE deptno1 = 101 AND deptno2 = 201;


--차집합
SELECT *
from emp
WHERE job = 'SALESMAN' AND comm > 400
MINUS
SELECT *
from emp --그동안 포상을 받은 직원 목록 emp_cele
WHERE hiredate < '1982-01-01';




