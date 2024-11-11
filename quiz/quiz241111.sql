--quiz

/*
emp2 dept2 테이블을 참고하여,

'AL Pacino'와 "같은 지역"에서
근무하는 직원들의 평균 연봉보다
많이 받는 직원들의 사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력하세요.
*/
SELECT *
FROM emp2
;

SELECT *
FROM dept2
;

-- 선생님하고 풀이
--1알파치노가 어디에서 일하느냐
SELECT *
FROM emp2
WHERE name = 'AL Pacino'
;

--2
SELECT area
FROM dept2
WHERE dcode = (알파치노가 속한부서)
;

--3
/*
평균급여보다 큰 직원들의 정보
<-평균급여
<- emp2에 직원들 목록 = deptno = dcode 서울브랜치에 위치한
<- 부서번호에 맞는 지역명을 뽑고(서울) = < 알파치노가 다니는 부서
*/

SELECT dcode
FROM dept2
WHERE area = (서울브랜치)
;

SELECT area
FROM dept2
WHERE dcode = (SELECT *
                FROM emp2
                WHERE name = 'AL Pacino')
;

SELECT dcode
FROM dept2
WHERE area = (SELECT area
                FROM dept2
                WHERE dcode = (SELECT *
                                FROM emp2
                                WHERE name = 'AL Pacino'))
;

--4 (평균급여)
select AVG(pay)
from emp2
where deptno IN (select dcode
                    from dept2
                    where area = (select area
                                    from dept2
                                    where dcode = (select deptno
                                                    from emp2
                                                    where name = 'AL Pacino')));


--5 많이 받는 직원들의 사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력
select e.empno, e.name, e.deptno,
d.dname,
d.area,
e.pay
from emp2 e, dept2 d
where pay > (select AVG(pay)
                from emp2
                where deptno IN (select dcode
                                    from dept2
                                    where area = (select area
                                                    from dept2
                                                    where dcode = (select deptno
                                                                    from emp2
                                                                    where name = 'AL Pacino'))))
AND e.deptno = d.dcode;






----------
--quiz


emp2 dept2 테이블을 참고하여,

'AL Pacino'와 "같은 지역"에서
근무하는 직원들의 평균 연봉보다
많이 받는 직원들의 사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력하세요.;

select *
from emp2;

select area
from dept2
where dcode = (select deptno
                from emp2
                where name = 'AL Pacino')
;

평균급여보다 큰 직원들 정보 
<- 평균급여 
<- emp2 에 직원들 목록 = deptno = dcode 서울브랜치에 위치한    
<- 부서번호에 맞는 지역명을 뽑고(서울) = < 알파치노가 다니는부서번호

select dcode
from dept2
where area = (select area
                from dept2
                where dcode = (select deptno
                                from emp2
                                where name = 'AL Pacino'));

select AVG(pay)
from emp2
where deptno IN (select dcode
                    from dept2
                    where area = (select area
                                    from dept2
                                    where dcode = (select deptno
                                                    from emp2
                                                    where name = 'AL Pacino')));


많이 받는 직원들의 사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력하세요.;

select * from dept2;

select empno, name, deptno, 
(select dname from dept2 where dcode = deptno) dname,
(select area from dept2 where dcode = deptno) area,
pay
from emp2
where pay > (select AVG(pay)
                from emp2
                where deptno IN (select dcode
                                    from dept2
                                    where area = (select area
                                                    from dept2
                                                    where dcode = (select deptno
                                                                    from emp2
                                                                    where name = 'AL Pacino'))));
              

select e.empno, e.name, e.deptno,
d.dname,
d.area,
e.pay
from emp2 e, dept2 d
where pay > (select AVG(pay)
                from emp2
                where deptno IN (select dcode
                                    from dept2
                                    where area = (select area
                                                    from dept2
                                                    where dcode = (select deptno
                                                                    from emp2
                                                                    where name = 'AL Pacino'))))
AND e.deptno = d.dcode;







SELECT e.empno AS 사번,
       e.name AS 이름, 
       e.deptno AS 부서번호,
       d.dname AS 부서이름,
       d.area AS 근무지역,
       e.pay AS 급여
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
AND e.pay > (
    SELECT AVG(e2.pay)
    FROM emp2 e2, dept2 d2
    WHERE e2.deptno = d2.dcode
    AND d2.area = (
        SELECT d3.area
        FROM emp2 e3, dept2 d3
        WHERE e3.deptno = d3.dcode
        AND e3.name = 'AL Pacino'
    )
)
ORDER BY e.pay DESC;


SELECT 
    e.empno,
    e.name,
    e.deptno,
    d.dname,
    d.area,
    e.pay
FROM emp2 e, (SELECT 
                    AVG(pay) avg_pay
                FROM emp2 e, dept2 d
                WHERE e.deptno = d.dcode
                AND area = (SELECT d.area
                            FROM emp2 e, dept2 d
                            WHERE e.name = 'AL Pacino'
                            AND e.deptno = d.dcode)) t, dept2 d
WHERE e.pay > t.avg_pay
AND e.deptno = d.dcode;






