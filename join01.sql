--join 01

SELECT *
FROM emp;

SELECT *
FROM dept;

--조인기준 deptno 가 같은
--테이블명 별칭 
--SELECT 
--    empno
--    ,ename
--    ,dname
--    ,loc
--    ,e.deptno

-- 나중에 테이블 많아지면 어딘지 모르니까 앞에 테이블 지금부터 붙여주기
--아래 같은 방식을 오라클에선 많이 사용한다.
SELECT 
    e.empno
    ,e.ename
    ,d.dname
    ,d.loc
    ,d.deptno
--SELECT *    
FROM emp e, dept d
WHERE e.deptno = d.deptno
;


SELECT 
    e.empno
    ,e.ename
    ,d.dname
    ,d.loc
    ,d.deptno
--SELECT *    
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
;



-- 잘못된 사용; 둘을 다 곱한 것
SELECT *    
FROM emp e, dept d
--WHERE e.deptno = d.deptno
;

--student <-profno-> professor
SELECT *
FROM student;

SELECT COUNT(*)
FROM student;

SELECT *
FROM professor;

-- null은 합쳐지지 않는다 데이터가 날아가버린다.
SELECT *
FROM student s, professor p
WHERE s.profno = p.profno
;

SELECT *
FROM student s INNER JOIN professor p
ON  s.profno = p.profno
;

--INNER JOIN vs OUTER JOIN
--OUTER JOIN:데이터가 null이라도 JOIN 하겠다
SELECT *
FROM student s, professor p
WHERE s.profno = p.profno(+)  --붙임을 당하는쪽에 (+)을 붙여준다
;

SELECT *
FROM student s LEFT OUTER JOIN professor p
--FROM student s RIGHT OUTER JOIN professor p
ON s.profno = p.profno
;

--학생 테이블(student)과 학과 테이블(department) , 교수 테이블(professor)을 
--Join하여 학생의 이름과 학생의 학과이름, 학생의 지도교수 이름을 출력하세요.

SELECT *
FROM student;

SELECT *
FROM professor;

SELECT *
FROM department;


SELECT 
    s.name STU_NAME
    ,d.dname DEPT_NAME
    ,p.name PROF_NAME
FROM student s, professor p, department d
WHERE 
    s.profno = p.profno 
    AND 
    s.deptno1 = d.deptno --student 학과번호 = department 학과번호
;

SELECT 
    s.name STU_NAME
    ,d.dname DEPT_NAME
    ,p.name PROF_NAME
FROM student s, professor p, department d
WHERE 
    s.profno = p.profno 
    AND 
    p.deptno = d.deptno --student 학과번호 = department 학과번호
;

--교수학과이름, 학생학과이름
SELECT 
    s.name
    ,s.deptno1
    ,d.dname
    ,s.profno
    ,p.profno
    ,p.name
    ,p.deptno
FROM student s, professor p, department d, department d2  --department d2 교수의 학과목
WHERE s.profno = p.profno
    AND s.deptno1 = d.deptno
    AND p.deptno = d2.deptno
;

SELECT 
    s.name STU_NAME
    ,d.dname DEPT_NAME
    ,p.name PROF_NAME
FROM 
    student s 
    INNER JOIN professor p
    ON s.profno = p.profno
    INNER JOIN department d
    ON s.deptno1 = d.deptno
;

SELECT *
FROM customer;

SELECT *
FROM gift;

-- 1~65000 ~100000

SELECT 
    c.gname
    ,c.point
    ,g.gname
FROM customer c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end
;


-- 아래 두개가 동일한 결과를 가지고 있지 않는다.
SELECT *
FROM student s, professor p
WHERE s.profno = p.profno(+) --학생테이블을 기준으로 교수정보를 붙이겠다
;

SELECT *
FROM student s, professor p
WHERE p.profno = s.profno(+) --교수테이블을 기준으로 학생정보를 붙이겠다
--WHERE s.profno(+) = p.profno
;

SELECT *
FROM student
;

SELECT *
FROM professor
;

SELECT *
FROM emp
;

--내사번, 내이름, 내 상사의 사번, 상사의 이름
-- 똑같은 테이블을 두고 비교하며 조인한다
SELECT 
    e1.empno
    ,e1.ename
    ,e1.mgr
    ,e2.empno
    ,e2.ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
;


