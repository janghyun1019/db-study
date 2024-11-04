

SELECT DEPTNO AS "부서번호",
       DNAME "부서이름",
       LOC "위치"
FROM dept;


SELECT name || '(' || ID || ')' AS "교수정보",
        position,
        hiredate AS "입사일자",
        email AS "이메일"
FROM PROFESSOR;