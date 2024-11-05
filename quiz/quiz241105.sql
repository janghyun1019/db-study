--1. 학생들 중에 키가 160~175인 학생들의 학번/이름/아이디 와
-- 교수들 중에 101/102/103/201 학과에 속하면서 보너스를 받지 않는 교수들의
-- 교수번호/이름/아이디 를 모두 취합해서 한번에 보여주시오.
SELECT *
FROM student;

SELECT *
FROM professor;


SELECT 
    studno as "번호", 
    name as "이름", 
    id as "아이디"
FROM student
WHERE height BETWEEN 160 AND 175
UNION ALL
SELECT 
    profno ,
    name,
    id
FROM professor
WHERE deptno IN (101, 102, 103, 201) AND bonus is null;

-2.학생들의 이름, 아이디, 주민번호를 아래와 같은 형태로 정리해서 보여주시오.

SELECT 
    '이름:' || name as "이름",
    '아이디:' || id "아이디",
    '주민번호:' || SUBSTR(jumin, 1,6) || '-' || SUBSTR(jumin, 7,7) AS "주민번호"
FROM student;
