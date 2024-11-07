--

/*
1.
student , department
이름이 'Anthony Hopkins' 인 학생과 1전공이 동일한 학생들의 정보 (이름, 학과번호, 학과이름) 출력하기.
*/

SELECT *
FROM student
;

SELECT *
FROM department
;

SELECT 
    s.name STUD_NAME
    ,s.deptno1 DEPT_NO
    ,d.dname DEPT_NAME
FROM 
    student s
    ,department d
WHERE s.deptno1 =  d.deptno
AND s.deptno1 = (SELECT deptno1
                 FROM student
                 WHERE name = 'Anthony Hopkins')
;

SELECT deptno1
FROM student
WHERE name = 'Anthony Hopkins'
;

-- 학생 이름, 부서 번호, 부서 이름을 선택
SELECT 
    s.name AS STUD_NAME        -- 학생 이름을 STUD_NAME으로 선택
    ,s.deptno1 AS DEPT_NO      -- 학생의 부서 번호를 DEPT_NO로 선택
    ,d.dname AS DEPT_NAME      -- 부서 이름을 DEPT_NAME으로 선택
FROM 
    student s                  -- student 테이블을 s라는 별칭으로 사용
    ,department d              -- department 테이블을 d라는 별칭으로 사용
WHERE 
    s.deptno1 = d.deptno       -- student와 department를 부서 번호로 조인
    AND s.deptno1 = (          -- 서브쿼리 결과와 일치하는 부서 번호만 선택
        SELECT deptno1
        FROM student
        WHERE name = 'Anthony Hopkins' -- 이름이 'Anthony Hopkins'인 학생의 부서 번호를 가져옴
    );



/*
2.
professor, department 테이블 활용. 
이름이 'Meg Ryan' 인 교수보다 나중에 입사한 사람의 이름, 입사일, 학과명 을 출력하세요.
*/
SELECT *
FROM professor
;

SELECT *
FROM department
;
--2
SELECT 
    p.name
    ,p.hiredate
    ,d.dname
FROM
    professor p,
    department d
WHERE p.deptno = d.deptno 
    AND p.hiredate > (SELECT
                        hiredatE
                        FROM professor 
                        WHERE name = 'Meg Ryan')
;

SELECT
    hiredat
FROM professor 
WHERE name = 'Meg Ryan';

-- 교수 이름, 입사일, 부서 이름을 선택
SELECT 
    p.name         -- 교수 이름을 선택
    ,p.hiredate    -- 교수 입사일을 선택
    ,d.dname       -- 교수의 부서 이름을 선택
FROM
    professor p    -- professor 테이블을 p라는 별칭으로 사용
    ,department d  -- department 테이블을 d라는 별칭으로 사용
WHERE 
    p.deptno = d.deptno  -- 교수와 부서를 부서 번호(deptno)로 조인
    AND p.hiredate > (  -- 교수의 입사일이 특정 교수보다 늦은 교수만 선택
        SELECT hiredatE
        FROM professor 
        WHERE name = 'Meg Ryan'  -- 'Meg Ryan' 교수의 입사일을 서브쿼리로 찾음
    );

--선생님풀이

SELECT 
    p.name
    ,p.hiredate
    ,d.dname
FROM
    professor p,
    department d
WHERE p.hiredate > (SELECT
                        hiredatE
                    FROM professor 
                    WHERE name = 'Meg Ryan')
AND p.deptno = d.deptno
;

SELECT
    hiredat
FROM professor 
WHERE name = 'Meg Ryan'
;

/*
3.
student 테이블, 
1전공이 201번 학과의 평균 몸무게보다 몸무게가 많이 나가는 학생들의 이름과 몸무게 출력하세요.
*/

SELECT *
FROM student
;
--3
SELECT 
    name, 
    weight
FROM student
WHERE weight > (SELECT 
                    AVG(weight) 
                FROM student 
                WHERE deptno1 = 201)
;

SELECT 
    AVG(weight) 
FROM student 
WHERE deptno1 = 201
;

-- 학생 이름과 체중을 선택
SELECT 
    name, 
    weight 
FROM student                            -- student 테이블에서 데이터를 조회
WHERE weight > (                        -- 학생의 체중이 특정 부서의 평균 체중보다 큰 학생만 선택
                SELECT 
                    AVG(weight)         -- 해당 부서의 평균 체중을 계산
                FROM student 
                WHERE deptno1 = 201     -- 부서 번호가 201인 학생들의 체중을 기준으로 평균 계산
                )
;

--선생님풀이

SELECT
    name
    ,weight
FROM student
WHERE weight >(SELECT 
                    AVG(weight) 
                FROM student 
                WHERE deptno1 = 201)
;

SELECT 
    AVG(weight) 
FROM student 
WHERE deptno1 = 201
;