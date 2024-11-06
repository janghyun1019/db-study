/*
1.
student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
각 학생 별로 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.
학번 이름 점수 학점 순으로 조회하세요.
*/

SELECT *
FROM student;

SELECT *
FROM score;

SELECT *
FROM hakjum;

SELECT
    s.studno 학번
    ,s.name 이름
    ,o.total 점수
    ,h.grade 학점    
FROM student s, score o, hakjum h
WHERE s.studno = o.studno
    AND o.total >= h.min_point
    AND o.total <= h.max_point
;

--선생님 풀이
SELECT 
    s.studno 학번
    ,s.name 이름
    ,sc.total 점수
    ,h.grade 학점
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
    AND sc.total BETWEEN h.min_point AND h.max_point
;    

/*
2.
student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
각 학생 별로 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.

학번 이름 점수 학점 순으로 조회하세요.

위 내역에서 101, 102 학과에 속한 학생들의 정보만 보여주세요.
*/
SELECT
    s.studno 학번
    ,s.name 이름
    ,o.total 점수
    ,h.grade 학점    
FROM student s, score o, hakjum h
WHERE s.studno = o.studno
    AND o.total >= h.min_point
    AND o.total <= h.max_point
    AND s.deptno1 IN (101,102)
;

--선생님 풀이
SELECT 
    s.studno 학번
    ,s.name 이름
    ,sc.total 점수
    ,h.grade 학점
FROM student s, score sc, hakjum h
WHERE s.studno = sc.studno
    AND sc.total BETWEEN h.min_point AND h.max_point
    AND S.deptno1 IN (101,102)
;

/*
3.
학생 테이블(student)과 학과 테이블(department) , 교수 테이블(professor) 을 Join하여
301학과 속한 교수를 제외한 교수를 지도교수로 두고 있는
학생의 이름과 학생의 학년, 학생의 지도교수 이름, 지도교수의 학과 번호, 지도교수가 속한 학과이름을 출력하세요.
*/
SELECT 
    s.name
    ,s.grade
    ,p.name
    ,p.deptno
    ,d.dname
FROM student s, professor p, department d
WHERE s.profno = p.profno
    AND p.deptno <> 301
    AND p.deptno = d.deptno
;

--선생님 풀이
SELECT
    s.name
    ,s.grade
    ,p.name
    ,p.deptno
    ,d.dname
FROM student s, professor p, department d
WHERE s.profno = p.profno
    AND p.deptno <> 301  --301학과 속한 교수를 제외한 교수
    AND p.deptno = d.deptno
;

SELECT *
FROM department;






