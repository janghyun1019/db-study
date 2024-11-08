/*1.
emp2 테이블 활용
직원 중 'Section head' 직급 최소 연봉자 보다 연봉이 높은 사람의 이름, 직급, 연봉을 출력하기.
*/

SELECT 
    name 이름
    ,emp_type 직급
    ,TO_CHAR(pay, '999,999,999') 연봉
FROM emp2
WHERE pay >any (SELECT MIN(pay)
                FROM emp2
                WHERE position = 'Section head')
;


SELECT MIN(pay)
FROM emp2
WHERE position = 'Section head'
;



/*
2.
Student 테이블.
전체 학생중에서 체중이 2학년 학생들의 체중에서 가장 적게 나가는 학생보다
몸무게가 더 적은 학생의 이름, 학년, 몸무게 출력
*/

SELECT *
FROM student
;

SELECT 
    name 이름
    ,grade 학년
    ,weight 몸무게
FROM student
WHERE weight <ALL (SELECT MIN(weight)
                    FROM student
                    WHERE grade = 2)
;

SELECT 
MIN(weight)
FROM student
WHERE grade = 2
;

/*
3.
emp2, dept2 활용
각 부서별 평균연봉을 구하고, 그 중에서 가장 작은 평균 연봉보다도 더 적게 받는 직원들의
부서명, 직원명, 연봉 출력
*/
SELECT * FROM emp2;

SELECT * FROM dept2;

SELECT 
    d.dname 부서명
    ,e.name 직원명
    ,TO_CHAR(e.pay, '999,999,999') 연봉
FROM emp2 e, dept2 d
WHERE e.deptno = d.dcode
AND e.pay <all (SELECT AVG(pay) 
                FROM emp2
                GROUP BY deptno )
;

SELECT AVG(pay) 
FROM emp2
GROUP BY deptno 
;

--최소값
SELECT MIN(AVG(pay)) 
FROM emp2
GROUP BY deptno 
;

--직계함수랑 일반행이랑 같이 쓰는 경우 안된다
SELECT MIN(AVG(pay)) 
FROM emp2
;
            -- pay 컬럼들의 평균값
SELECT AVG(pay) --컬럼명 AVG(pay) XX 함수를 다시부른다고 하기때문에 안된다
FROM (SELECT AVG(pay) ABC  --컬럼명 AVG(pay)
        FROM emp2
        GROUP BY deptno)
;

--java avgPay 캐멀케이스
--DB   avg_pay

SELECT AVG(avg_pay) 
FROM (SELECT AVG(pay) avg_pay  --컬럼명 AVG(pay)
        FROM emp2
        GROUP BY deptno)
;

SELECT MIN(avg_pay) -- 다시뽑아낼수 있다
FROM (SELECT AVG(pay) avg_pay  --컬럼명 AVG(pay)
        FROM emp2
        GROUP BY deptno)
;


SELECT 1+2+3 RESULT FROM dual;
