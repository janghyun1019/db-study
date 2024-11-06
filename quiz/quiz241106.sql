/*emp2 테이블을 기준으로 아래 정보를 출력
사원들 중에 70년대 생이면서 지역번호를 기준으로 서울(02), 경기도(031)에 거주하는
사원들의 정보를 아래와 같이 출력하시오.
사번, 이름, 생년월일, 취미, 급여(pay), 성과급(급여의 150%)
, 직원분류(단, 가족과 같은 직원이라서 family로 표기)
,전화번호, 급여수준
(단, 급여수준은 아래와 같이 분류)
3500만 1원 ~ 4500만 : '하'
4500만 1원 ~ 6천만 : '중"
6000만 1원 이상 : '상'
그 외... : '화이팅'
*/

SELECT *
FROM emp2;


--선생님풀이

SELECT
    empno 사번
    ,name 이름
    ,birthday 생년월일
    ,hobby 취미
    ,pay 급여
    ,pay*1.5 성과급
    ,REPLACE(emp_type, 'employee', 'family') 직원분류
    -- SUBSTR(emp_type, 1, INSTR(emp_type, ' ')) || 'family'
    ,tel
    ,CASE
        WHEN pay BETWEEN 35000001 AND 45000000 THEN '하'
        WHEN pay BETWEEN 45000001 AND 65000000 THEN '중'
        WHEN pay > 60000000 THEN '상'
        ELSE '화이팅!'
     END
FROM emp2
WHERE 
    TO_CHAR(birthday, 'YY') BETWEEN 70 AND 79
    AND
    SUBSTR(tel, 1, INSTR(tel,')')-1) IN ('02' , '031');




--내풀이ㅠ
SELECT    
    empno AS 사번,
    name AS 이름,
    birthday AS 생년월일,
    hobby AS 취미,
    pay AS 급여,
    pay * 1.5 AS 성과급,
    EMP_TYPE AS 직원분류,
    tel AS 전화번호,
    CASE
        WHEN pay BETWEEN 35000001 AND 45000000 THEN '하'
        WHEN pay BETWEEN 45000001 AND 60000000 THEN '중'
        WHEN pay > 60000000 THEN '상'
        ELSE '화이팅'
    END AS 급여수준
FROM emp2
WHERE 
    TO_CHAR(birthday, 'YYYY') BETWEEN '1970' AND '1979'
    AND (SUBSTR(tel, 1, 2) = '02' OR SUBSTR(tel, 1, 3) = '031');