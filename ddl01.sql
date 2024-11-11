--ddl

--컬럼이름, 타입
--테이블 만들기

--생성
CREATE TABLE new_table
(
    no NUMBER(3)
    ,name VARCHAR2(10)
    ,birth DATE
);    

SELECT *
FROM new_table
;

DESC new_table;

SELECT SYSDATE FROM dual;  
--SYSDATE: 게시글 일자, 공지일자 등등 그일이 발생한 저장한 시점

CREATE TABLE tt02
(
    no NUMBER(3,1) DEFAULT 0,
    name VARCHAR2(10) DEFAULT 'NO Name',
    hiredate DATE DEFAULT SYSDATE
);

SELECT * FROM tt02;


--복사



CREATE TABLE dept3     --구조 + 데이터 전체복사
AS
SELECT * FROM dept2;  

SELECT * FROM dept3;

CREATE TABLE dept4   --컬럼2개 + 데이터 복사
AS
SELECT dcode, area FROM dept2; 

SELECT * FROM dept4;

SELECT *
FROM dept2
WHERE area = 'Seoul Branch Office';

--구조만 복사
CREATE TABLE dept5    -- 컬럼구조만 복사 (데이터 X)
AS
SELECT *
FROM dept2
WHERE 1=2;     --거짓 조건

SELECT * FROM dept5;

--테이블 변경
ALTER TABLE dept4
ADD(location VARCHAR2(10));  -- 컬럼추가

ALTER TABLE dept4
ADD(location VARCHAR2(10) DEFAULT 'Cheonan');


-- ?? 이거 추가 안됨
INSERT INTO dept4
VALUES(2000, 'Cheonan Office');

--임시부서 여부를 체크 컬럼명 temp_code 'Y' 임시부서 , 'N' 정식부서
ALTER TABLE dept4
ADD (temp_code VARCHAR2(2) DEFAULT 'N');

SELECT * FROM dept4;

--컬럼 삭제
ALTER TABLE dept4
DROP COLUMN location;

CREATE TABLE dept6
AS
SELECT * FROM dept4;

SELECT * FROM dept5;
SELECT * FROM dept6;

--테이블 삭제 (rollback불가 / 자동 commit가 일어남)
DROP TABLE dept5;
--삭제는 롤백이 안됨
--정확하게 확인하고 사용해야함 **돌이킬수 없는 상황 발생

TRUNCATE TABLE dept6;
--Table DEPT6이(가) 잘렸습니다.
--안에 데이터가 싹 사라짐

--DDL쪽은 왠만하면 건드리지 말자 ;)


