/*
1.
student, department 테이블 활용
학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.
사용자가 올린 이미지
*/
--1)다중컬럼 비교
select height MAX_HEIGHT, name, height
FROM student
WHERE (deptno1, height) IN (SELECT deptno1, MAX(height)
                            FROM student
                            GROUP BY deptno1)
;

--1-1) join
select
    s.height MAX_HEIGHT, s.name, s.height
FROM student s, department d
WHERE (s.deptno1, s.height) IN (SELECT deptno1, MAX(height)
                            FROM student
                            GROUP BY deptno1)
;

--1-2) 서브쿼리
select 
    (SELECT dname
    FROM department
    WHERE deptno = deptno1) DNAME,
    height MAX_HEIGHT, name, height
FROM student
WHERE (deptno1, height) IN (SELECT deptno1, MAX(height)
                            FROM student
                            GROUP BY deptno1)
;


--2) 인라인뷰(서브쿼리)

SELECT t.max_height, s.name, s.height 
FROM (SELECT deptno1, MAX(height) MAX_HEIGHT
        FROM student
        GROUP BY deptno1) t, student s
WHERE t.deptno1 = s.deptno1
AND t.max_height = s.height
;

--2-1) join
SELECT t.max_height, s.name, s.height 
FROM (SELECT deptno1, MAX(height) MAX_HEIGHT
        FROM student
        GROUP BY deptno1) t, student s, department d
WHERE t.deptno1 = s.deptno1
AND t.max_height = s.height
AND t.deptno1 = d.deptno
-- AND s.deptno1 = d.deptno 
;
--2-2) subquery

SELECT 
    (SELECT dname
    FROM department
    WHERE deptno = t.deptno1) dname
    ,t.max_height
    ,s.name
    ,s.height 
FROM (SELECT deptno1, MAX(height) MAX_HEIGHT
        FROM student
        GROUP BY deptno1) t, student s
WHERE t.deptno1 = s.deptno1
AND t.max_height = s.height
;


---------------------------

/*
2.
student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 학년과 이름과 키,
해당 학년의 평균 키를 출력 하세요.
(학년 컬럼으로 오름차순 정렬해서 출력하세요)
*/
--학년별평균키
SELECT 
    grade,
    AVG(height)
FROM student
GROUP BY grade;


SELECT
    s.grade
    ,s.name
    ,s.height
    ,t.avg_height
FROM 
    (SELECT grade, AVG(height) avg_height
    FROM student
    GROUP BY grade) t, student s
WHERE t.grade = s.grade
AND t.avg_height < s.height
ORDER BY s.grade
;

SELECT
    s.grade
    ,s.name
    ,s.height
    ,(SELECT 
          AVG(t.height)
      FROM student t
      WHERE t.grade =  s.grade) avg_height
FROM student s
WHERE s.height > (SELECT 
                    AVG(t.height)
                  FROM student t
                  WHERE t.grade =  s.grade)
ORDER BY s.grade                  
;                  



