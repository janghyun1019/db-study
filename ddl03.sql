--ddl03

--REFERENCES
-- 외래키 참조하는 테이블(부모)에 존재하는 값만 저장 가능(+null 가능)
-- 외래키 설정된 테이블(부모)에서 자신을 참조하는 데이터가 존재하는 경우, 삭제 불가

--외래키 삭제조건 (편하긴한데 잘 안씀) 혹시나 잘못지웠을 경우를 대비해서 쓰지 않는다
ON DELETE CASCADE; -- 부모 데이터 삭제시, 그 값을 참조하는 자식 데이터도 같이 삭제(종속되서 같이 지워짐)
ON DELETE SET NULL; --부모 데이터 삭제시, 참조하는 자식 데이터  null로 변경

DROP TABLE T_MEMBER;

CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR(30)
    ,club_id REFERENCES T_CLUB(id)
--    ,club_id REFERENCES T_CLUB(id) ON DELETE SET NULL
--    ,club_id REFERENCES T_CLUB(id) ON DELETE CASCADE
);

CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR(30)
    
);

CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR2(30)
);

SELECT * FROM t_club;

INSERT INTO T_CLUB
VALUES (1, '독서');

INSERT INTO T_CLUB
VALUES (2, '등산');

INSERT INTO T_CLUB
VALUES (3, '낚시');

INSERT INTO T_MEMBER
VALUES (1, '가이름', 3);

SELECT * FROM T_MEMBER;

SELECT *
FROM T_MEMBER M, t_club c
WHERE M.CLUB_id = c.id;

INSERT INTO T_MEMBER
VALUES (2, '나이름', 8);
--ORA-02291: 무결성 제약조건(SCOTT.SYS_C007513)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO T_MEMBER
VALUES (2, '나이름', 2);

INSERT INTO T_MEMBER
VALUES (3, '다이름', 1);

INSERT INTO T_MEMBER
VALUES (4, '라이름', null);

SELECT * FROM t_club;

SELECT * FROM T_MEMBER;

DELETE 
FROM t_club
WHERE id = 3;
--ORA-02292: 무결성 제약조건(SCOTT.SYS_C007513)이 위배되었습니다- 자식 레코드가 발견되었습니다
--지울수 없다

SELECT *
--DELETE 
FROM t_club
WHERE id = 1;

UPDATE t_member
SET club_id = null
WHERE id = 1;  -- 값을 null로 변경후 제약조건 없앤 후 삭제가 가능하다

-- 데이터 딕셔너리
-- USER_ / DBA_ / ALL_
-- INDEXES / CONSTRAINTS / TABLES / SEQUENCES / SYNONYMS
-- VIEWS / ROLE_PRIVS

SELECT *
FROM USER_ROLE_PRIVS;

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;  -- 모든테이블

--OWNER 컬럼 : 누가 만든지 알수 있다

SELECT * 
FROM TAB;  --테이블 이름 정보

SELECT * 
FROM tab
WHERE tname LIKE '%STU%';

--
CREATE TABLE tt05
(
    id number PRIMARY KEY
    ,no number PRIMARY KEY
    ,age number
);
--  PRIMARY KEY 따로 쓸땐 하나만 가능하다
--ORA-00901: CREATE 명령어가 부적합합니다

CREATE TABLE tt05
(
    id number 
    ,no number 
    ,age number
    ,CONSTRAINT tt05_pk PRIMARY KEY (id, no)  -- id, no 두개 컬럼을 묶어서 PK 가능
);


