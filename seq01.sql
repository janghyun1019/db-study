--seq01

CREATE TABLE seq_test
(
    no NUMBER(3) PRIMARY KEY
    ,name VARCHAR2(32)
);

SELECT * FROM seq_test;
--유니크하고 NOT NULL이어야 함
--보고 수동으로 일일이 저장
INSERT INTO seq_test VALUES (1, '가이름');
--다음 가입자 이름 '나이름' 저장
INSERT INTO seq_test VALUES (2, '나이름');
--String saveName = '다이름';

--서브쿼리로 갯수 활용
SELECT COUNT(*) FROM seq_test;  -- 현재저장된 갯수
SELECT COUNT(*)+1 FROM seq_test;  -- 다음 저장할 차례 값

INSERT INTO seq_test VALUES (no<- 여기를 다음 들어 갈 숫자로 서브쿼리로 저장해줌, '나이름');

INSERT INTO seq_test VALUES ((SELECT COUNT(*)+1 FROM seq_test), '다이름');
INSERT INTO seq_test VALUES ((SELECT COUNT(*)+1 FROM seq_test), '라이름');
INSERT INTO seq_test VALUES ((SELECT COUNT(*)+1 FROM seq_test), '마이름');

--테이블 관리(구조를 잡고 관리를 할때)
    --데이터 삭제로 관리하는 테이블이라고 가정을 하면
    SELECT * FROM seq_test;
    --다 탈퇴 -> 삭제
    delete from seq_test
    WHERE no = 3;

INSERT INTO seq_test VALUES ((SELECT COUNT(*)+1 FROM seq_test), '바이름');

-- 서브쿼리로 갯수 -> no PK값을 따져보고 활용
SELECT no FROM seq_test; --pk 따지겠다
SELECT MAX(no) FROM seq_test; -- 제일 큰 PK값
SELECT MAX(no)+1 FROM seq_test; -- 제일 큰 PK값 다음 값

INSERT INTO seq_test VALUES ((SELECT MAX(no)+1 FROM seq_test), '바이름');

SELECT * FROM seq_test;

INSERT INTO seq_test VALUES ((SELECT MAX(no)+1 FROM seq_test), '사이름');

DELETE FROM seq_test
    WHERE no = 7;

INSERT INTO seq_test VALUES ((SELECT MAX(no)+1 FROM seq_test), '아이름');

DELETE FROM seq_test;

INSERT INTO seq_test VALUES ((SELECT MAX(no)+1 FROM seq_test), '자이름');
--위에 다 지워버려서 MAX값이 null이라 찾을수가 없어서 오류가 난다

SELECT NVL(MAX(no), 0)+1 FROM seq_test;

INSERT INTO seq_test VALUES ((SELECT NVL(MAX(no), 0)+1 FROM seq_test), '자이름');

SELECT * FROM seq_test;

INSERT INTO seq_test VALUES ((SELECT NVL(MAX(no), 0)+1 FROM seq_test), '차이름');
INSERT INTO seq_test VALUES ((SELECT NVL(MAX(no), 0)+1 FROM seq_test), '카이름');

DELETE FROM seq_test
    WHERE no = 2;

INSERT INTO seq_test VALUES ((SELECT NVL(MAX(no), 0)+1 FROM seq_test), '타이름');

--순차적으로 중복되지 않는 값을 사용 -> 시퀀스

CREATE SEQUENCE seq_test_pk_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 10
CYCLE     --계속 돌게 하는 기능
CACHE 5;
--NOCYCLE;
--(CACHE 20)

DROP SEQUENCE seq_test_pk_seq;  --시퀀스 삭제

--시퀀스명.nextval 다음값 호출
--시퀀스명.currval 현재값 확인

SELECT seq_test_pk_seq.nextval FROM dual; --실행할때마다 1씩증가
SELECT seq_test_pk_seq.currval FROM dual;

CREATE SEQUENCE seq_test_pk_seq
INCREMENT BY 1
START WITH 1;
--MIN/MAX 따로 체크안함
--NOCYCLE
--CACHE 20

SELECT * FROM seq_test;
DELETE FROM seq_test;
SELECT seq_test_pk_seq.nextval FROM dual;

INSERT INTO seq_test VALUES (seq_test_pk_seq.nextval, 'A이름');
INSERT INTO seq_test VALUES (seq_test_pk_seq.nextval, 'B이름');

INSERT INTO seq_test VALUES (seq_test_pk_seq.nextval, 'C이름');
INSERT INTO seq_test VALUES (seq_test_pk_seq.nextval, 'D이름');

SELECT *
FROM user_sequences;

--시퀀스 값 확인
SELECT seq_test_pk_seq.currval FROM dual;  --현재값4 nextval5 1씩증가
--1이 될 수 있도록 증가값을 변경
ALTER SEQUENCE seq_test_pk_seq INCREMENT BY -17;
ALTER SEQUENCE seq_test_pk_seq MINVALUE 0;
--시퀀스 1회 실행
SELECT seq_test_pk_seq.nextval FROM dual;
--다시 증가값 설정 변경
ALTER SEQUENCE seq_test_pk_seq INCREMENT BY 1;

SELECT seq_test_pk_seq.nextval FROM dual;










