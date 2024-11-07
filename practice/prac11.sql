--prac11

-- sql 연습문제 추가

/*
1. 학생 테이블 (student) 과 학과 테이블 (department) 테이블을 사용하여 
학생이름, 1전공학과번호(deptno1) , 1전공 학과 이름을 출력하세요.
*/
SELECT *
FROM student
;

SELECT *
FROM department
;

SELECT 
    s.name STU_NAME
    ,s.deptno1 DEPTNO1
    ,d.dname DEPT_NAME
FROM student s, department d
WHERE s.deptno1 = d.deptno
;

--선생님 풀이
--캡처join5

/*
2. emp2 테이블과 p_grade 테이블을 조회하여 현재 직급이 있는 사원의 이름과 직급, 현재 연봉,
해당 직급의 연봉의 하한금액과 상한 금액을 아래 결과 화면과 같이 출력하세요.
*/

SELECT *
FROM emp2
;

SELECT *
FROM p_grade
;

SELECT
    e.NAME 
    ,p.POSITION
    ,TO_CHAR(e.PAY, 'FM999,999,999,999') PAY
    ,TO_CHAR(p.S_PAY, 'FM999,999,999,999') LOWPAY  
    ,TO_CHAR(p.E_PAY, 'FM999,999,999,999') HIGHTPAY   --FM은 앞에 빈자리 없게 만들어줌
FROM emp2 e, p_grade p
WHERE e.POSITION = p.POSITION
;

-- 선생님풀이
SELECT
    e.name                                              -- 4 보여줄것 나열
    ,e.position
    ,TO_CHAR(e.PAY, 'FM999,999,999,999') PAY
    ,TO_CHAR(p.S_PAY, 'FM999,999,999,999') LOWPAY  
    ,TO_CHAR(p.E_PAY, 'FM999,999,999,999') HIGHTPAY
FROM emp2 e, p_grade p      -- 2
WHERE e.position is not NULL  -- 1직급이 있는 사원 찾기
AND e.position =  p.position(+)  -- 3두개를 연결하겠다 5.(+) 직급이 없는 보스가 나오도록 아웃터 붙여줌ㅎ
;


/*
3. Emp2 테이블과 p_grade 테이블을 조회하여
사원들의 이름과 나이, 현재 직급 , 예상 직급 을 출력하세요.
예상 직급은 나이로 계산하며 해당 나이가 받아야 하는 직급을 의미합니다.
나이는 '2010-05-30'을 기준으로 하되 가능하면 trunc 로 소수점 이하는 절삭해서 계산하세요.
*/

SELECT 
    e.name "이름"
    ,trunc((TO_DATE('2010-05-30')-e.birthday)/365+1,0) "현재나이"
    ,e.position "현재직급"
    ,g.position "예상직급"
FROM emp2 e , p_grade g
WHERE trunc((TO_DATE('2010-05-30')-e.birthday)/365+1,0) BETWEEN g.s_age AND g.e_age ;

--선생님풀이
SELECT 
    birthday
    ,'2010-5-30'
    ,SUBSTR('2010-05-30', 1, 4)
    ,TO_CHAR(birthday,'YYYY')
    ,2010
    ,2010-TO_CHAR(birthday,'YYYY')+1 나이
    ,TRUNC((SYSDATE - birthday)/365,0) 나이
    ,TRUNC((TO_DATE('2010-05-30') - birthday)/365,0) 나이
from emp2;

SELECT 2010-1972+1 FROM dual;

SELECT 2010-1980+1 FROM dual;

SELECT 2010-1985+1 FROM dual;

SELECT * FROM p_grade;

--SYSDATE : 오늘날짜


SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2010-05-30'))/12
FROM dual;


SELECT
    e.name
    ,TO_CHAR(TO_DATE('2010-05-30'), 'YYYY') - TO_CHAR(birthday, 'YYYY') + 1 한국나이
    ,e.position 지금포지션
    ,p.position 지금나이에맞는포지션
FROM 
    emp2 e
    ,p_grade p
WHERE 
    TO_CHAR(TO_DATE('2010-05-30'), 'YYYY') - TO_CHAR(birthday, 'YYYY') + 1 
    BETWEEN p.s_age AND p.e_age
--WHERE 계산한 나이 BETWEEN p.s_age AND p.e_age
;


/*
4 . customer 테이블과 gift 테이블을 Join하여 고객이 자기 포인트보다 낮은 포인
트의 상품 중 한가지를 선택할 수 있다고 할 때 Notebook 을 선택할 수 있는 고객
명과 포인트, 상품명을 출력하세요.
*/

SELECT *
FROM customer;

SELECT *
FROM gift;


SELECT
    c.gname, c.point, g.gname
FROM customer c, gift g
WHERE c.point >= g.g_start AND g.gname = 'Notebook'
;

SELECT
    c.gname,                    -- customer 테이블에서 고객 이름(gname)을 선택
    c.point,                    -- customer 테이블에서 고객 포인트(point)를 선택
    g.gname G_NAME                    -- gift 테이블에서 상품 이름(gname)을 선택
FROM 
    customer c,                 -- customer 테이블을 c라는 별칭으로 사용
    gift g                      -- gift 테이블을 g라는 별칭으로 사용
WHERE 
    c.point >= g.g_start        -- 고객 포인트가 선물(gift) 테이블의 최소 포인트(g_start)보다 크거나 같은 경우
    AND g.gname = 'Notebook';   -- gift 테이블의 상품 이름이 'Notebook'인 경우에만 선택

--선생님 풀이

SELECT *
FROM customer;

SELECT *
FROM gift;

SELECT
    c.gname
    ,c.point
    ,'Notebook' GNAME
FROM 
    customer c
    ,gift g
WHERE 
    c.point BETWEEN g.g_start AND g.g_end
    AND
    g.gno >= 7
    --c.point >600000
;

SELECT *
FROM 
    customer c
    ,gift g
WHERE 
    c.point > g.g_start
    AND
    g.gno = 7
    --g.gname = 'Notebook'
;
 
--동명2인이 있을 수 있을테니까 딱 한사람만 불러오고 싶다
--식별자가 딱
-- 위에꺼 g.gno = 7로 사용하는 것이 좋다
--데이터 설계시 변하지 않는 것으로 하는 것이 좋다


/*
5. professor 테이블에서 교수의 번호, 교수이름, 입사일, 자신보다 입사일 빠른 사람 인원수를 출력하세요.
단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.
*/
SELECT *
FROM professor;

--5
SELECT
    p1.profno
    ,p1.name
    ,TO_CHAR(p1.hiredate, 'YY/MM/DD') HIREDATE
    ,COUNT(NVL2(p2.profno, p1.profno, NULL)) COUNT
FROM
    professor p1,
    professor p2
WHERE p1.hiredate > p2.hiredate(+)
GROUP BY 
    p1.profno
    ,p1.name
    ,p1.hiredate
ORDER BY COUNT ASC
;

SELECT
    p1.profno,                           -- 첫 번째 테이블(p1)에서 교수 번호(profno)를 선택
    p1.name,                             -- 첫 번째 테이블(p1)에서 교수 이름(name)을 선택
    TO_CHAR(p1.hiredate, 'YYYY/MM/DD') HIREDATE,  -- p1의 고용 날짜(hiredate)를 'YYYY/MM/DD' 형식의 문자열로 변환하여 HIREDATE라는 별칭으로 선택
    COUNT(NVL2(p2.profno, p1.profno, NULL)) COUNT  -- p2.profno 값이 NULL이 아니면 p1.profno를 카운트하여 'COUNT'라는 별칭으로 표시
FROM
    professor p1,                        -- professor 테이블을 p1이라는 별칭으로 사용
    professor p2                         -- professor 테이블을 p2라는 별칭으로 사용하여 p1과 비교
WHERE p1.hiredate > p2.hiredate(+)       -- p1의 고용 날짜가 p2의 고용 날짜보다 늦을 경우에만 선택 (외부 조인 사용)
GROUP BY 
    p1.profno,                           -- 교수 번호(profno)를 기준으로 그룹화
    p1.name,                             -- 교수 이름(name)을 기준으로 그룹화
    p1.hiredate                          -- 고용 날짜(hiredate)를 기준으로 그룹화
ORDER BY COUNT ASC                      -- COUNT 값을 기준으로 오름차순 정렬
;


--선생님풀이
SELECT
    profno
    ,name
    ,hiredate
    ,RANK() OVER (ORDER BY hiredate) - 1 COUNT
FROM professor
ORDER BY COUNT ASC
;

SELECT
    p1.profno
    ,p1.name
    ,p1.hiredate
    ,COUNT(p2.profno) COUNT                       --COUNT(*) : NULL은 갯수로 세지 않는다
FROM
    professor p1,                        -- professor 테이블을 p1이라는 별칭으로 사용
    professor p2                         -- professor 테이블을 p2라는 별칭으로 사용하여 p1과 비교
WHERE p1.hiredate > p2.hiredate(+)      --아웃터 조인 해줘야 함
GROUP BY 
    p1.profno
    ,p1.name
    ,p1.hiredate
ORDER BY p1.hiredate    
;



/*
6. emp 테이블에서 사원번호, 사원이름, 입사일, 자신보다 먼저 입사한 사람 인원수를 출력하세요.
단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.
*/

SELECT *
FROM emp
;

SELECT e1.empno,
       e1.ename,
       e1.hiredate,
       COUNT(e2.hiredate) "COUNT"
FROM emp e1
LEFT OUTER JOIN emp e2             -- e2라는 별칭으로 emp 테이블을 왼쪽 외부 조인으로 다시 사용
ON e1.hiredate > e2.hiredate       -- e1의 고용 날짜가 e2의 고용 날짜보다 큰 경우, e1이 더 늦게 고용된 경우에만 조인
GROUP BY e1.empno,                 
         e1.ename,
         e1.hiredate
ORDER BY 4;  


SELECT e1.empno,                   -- 첫 번째 테이블 (e1)에서 직원 번호(empno)를 선택
       e1.ename,                   -- 첫 번째 테이블 (e1)에서 직원 이름(ename)을 선택
       e1.hiredate,                -- 첫 번째 테이블 (e1)에서 고용 날짜(hiredate)를 선택
       COUNT(e2.hiredate) "COUNT"  -- e2의 고용 날짜를 기준으로 고용된 직원 수를 카운트하여 "COUNT"라는 별칭으로 표시
FROM emp e1                        -- e1이라는 별칭으로 emp 테이블을 사용
LEFT OUTER JOIN emp e2             -- e2라는 별칭으로 emp 테이블을 왼쪽 외부 조인으로 다시 사용
ON e1.hiredate > e2.hiredate       -- e1의 고용 날짜가 e2의 고용 날짜보다 큰 경우 (즉, e1이 더 늦게 고용된 경우에만 연결)
GROUP BY e1.empno,                 -- 직원 번호(empno)를 기준으로 그룹화
         e1.ename,                 -- 직원 이름(ename)을 기준으로 그룹화
         e1.hiredate               -- 고용 날짜(hiredate)를 기준으로 그룹화
ORDER BY 4;                        -- 네 번째 컬럼 (COUNT) 기준으로 정렬 (오름차순 기본)


-- 5번을 가지고 변경
SELECT
    e1.empno
    ,e1.ename
    ,e1.hiredate
    ,COUNT(e2.hiredate) "COUNT"                       
FROM
    emp e1                        
    ,emp e2                         
WHERE e1.hiredate > e2.hiredate(+)      
GROUP BY 
    e1.empno
    ,e1.ename
    ,e1.hiredate
ORDER BY 4    
;

--선생님풀이
SELECT
    e1.empno
    ,e1.ename
    ,e1.hiredate
    ,COUNT(e2.hiredate) "COUNT"                       
FROM
    emp e1                        
    ,emp e2                         
WHERE e1.hiredate > e2.hiredate(+)      
GROUP BY 
    e1.empno
    ,e1.ename
    ,e1.hiredate
ORDER BY e1.hiredate    
;
