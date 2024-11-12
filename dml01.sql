--dml

--데이터 저장 INSTER
--데이터 수정 UPDATE
--데이터 삭제 DELETE
--데이터 병합 MERGE


/*
데이터 저장 INSTER

INSERT INTO 테이블명 (컬럼명...)
VALUES (데이터값...);
*/

INSERT INTO new_table (no, name, birth)
VALUES(1, '이름1', SYSDATE);

INSERT INTO new_table (name, birth, no)
VALUES('이름2', SYSDATE, 2);

INSERT INTO new_table (name, birth, no)
VALUES('이름3', '2002-02-15', 3);

INSERT INTO new_table (name, birth, no)
VALUES('이름4', TO_DATE('2002-02-15'), 4);

--컬럼명 생략
--전체 컬럼에 저장하는 경우 + 순서
--갯수 타입 컬럼명 맞으면됨
INSERT INTO new_table
VALUES(5, '이름5', SYSDATE);

INSERT INTO new_table (no, name)
VALUES(65, '이름6');

INSERT INTO new_table
VALUES(7, '이름7', null);

-- 여러개 동시에 삽입(저장) INSERT ALL
SELECT * FROM tt02;

INSERT ALL
INTO tt02 VALUES (7, '이름7', null)
INTO tt02 VALUES (8, '이름8', null)
INTO tt02 VALUES (9, '이름9', null)
INTO tt02 VALUES (10, '이름10', null)
SELECT * FROM dual;

INSERT INTO tt02 --number3 varchar2 date
SELECT 11, '샘플', SYSDATE FROM dual;


-- 여러개를 삽입할수 있다
INSERT INTO tt02 --tt02 테이블 전부 dept로 삽입 
SELECT deptno, loc, SYSDATE FROM dept;





--날짜 입력할땐 TO_DATE('2002-02-15') 이런형식으로 해야함

----

INSERT INTO tt02 (no)
VALUES (1);

INSERT INTO tt02 (no, name, hiredate)
VALUES (2, null, null);
--일부러 null을 넣었다



/*
데이터 수정 UPDATE

UPDATE 테이블명
SET 컬럼명 =  값
WHERE 조건
*/

--임시부서 여부를 체크 컬럼명 temp_code 'Y' 임시부서 , 'N' 정식부서
SELECT * FROM dept4;

UPDATE dept4
SET temp_code = 'N';

UPDATE dept4
SET temp_code = 'Y'
WHERE dcode = 2000;    --dcode 2000이상을 y로 변경

SELECT *
FROM dept4
WHERE temp_code = 'Y';


CREATE TABLE professor2
AS
SELECT * FROM professor;

SELECT * 
FROM professor2
WHERE position  = 'assistant professor';

UPDATE professor2
SET bonus = 200
WHERE position = 'assistant professor';
-- 보너스를 200으로 저장하라

UPDATE professor2
SET bonus = bonus + 200
WHERE position = 'assistant professor';
--원래 보너스에 200을 더 해줘라(인상)

commit;  --실제 DB값이 바뀜 (확정)
rollback;  

-- 커밋을해야 확정

SELECT *
FROM dept4;

SELECT *
FROM dept4
WHERE dcode =  1011;

UPDATE dept4
SET location = 'Asan'
WHERE dcode =  2000;

UPDATE dept4   --수정
SET area = 'Asan Office'
WHERE dcode =  2001;

UPDATE dept4   --수정
SET temp_code = 'Y'
WHERE dcode =  2000;

INSERT INTO dept4  --추가
VALUES (2001, 'Asan Offfice', 'Asan', 'Y');

/*
데이터 삭제 DELETE
3. DELETE
DELETE 문장은 데이터를 삭제하는 구문입니다.

(rollback 가능 / 자동 commit이 안일어남)
*/
SELECT * FROM dept4;

DELETE FROM dept4;
rollback;  --롤백으로 살림

SELECT *
--DELETE
FROM dept4
WHERE temp_code = 'Y';

