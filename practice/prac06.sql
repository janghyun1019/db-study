/*
[ NVL2 함수 퀴즈 ]
아래 화면과 같이 emp 테이블에서 deptno 가 30 번인 사원들을 조회하여 comm
값이 있을 경우 'Exist' 을 출력하고 comm 값이 null 일 경우 'NULL' 을 출력하세요.
*/
-- sal*12 + comm = 총 연봉 NVL NVL2
SELECT
    empno,
    ename,
    comm,
    sal*12 + comm TOTAL,
    SAL*12 + NVL(comm, 0) TOTAL2,
    SAL*12 + NVL2(comm, comm, 0) TOTAL3,
    NVL2(comm, sal*12+comm, sal*12) TOTAL4
FROM emp
WHERE deptno = 30;


--캡쳐9

/*
연습문제

emp 테이블을 조회하여 comm 값을 가지고 있는 사람들의 empno , ename , hiredate,
총연봉,15% 인상 후 연봉을 아래 화면처럼 출력하세요.
단 총연봉은 (sal*12)+comm 으로 계산하고
아래 화면에서는 SAL 로 출력되었으며
15% 인상한 값은 총연봉의 15% 인상 값입니다.
*/


SELECT
    empno,
    ename,
    TO_CHAR(hiredate, 'YY-MM-DD') HIREDATE,
    TO_CHAR((sal*12)+comm, '$999,000') "SAL",
    TO_CHAR((sal*12)+comm * 1.15, '$999,000') "15% UP"
FROM emp
WHERE comm IS NOT NULL;


