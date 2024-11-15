/*
1.아래 정보를 관리할 수 있는 테이블 (T_PERSON_INFO) 테이블을 생성한 후, 주어진 데이터를 저장하시오.
(*테이블명이 고정이며, 그외에 컬럼명과 컬럼 사이즈는 적절하게 설정할 것)
*학번 은 기본키 역활을 할 것.

학생 정보는 순서대로 학번 / 이름 / 나이 / 전공

20210034 이상형 21 법학과
20220011 김건우 24 물리학과
20240109 전지훈 20 컴퓨터공학과
20230002 강순구 21 건축학과
*/


--T_PERSON_INFO 테이블 생성
CREATE TABLE T_PERSON_INFO (
    student_id VARCHAR(8) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL,        
    age NUMBER(3) NOT NULL,                  
    major VARCHAR(50) NOT NULL        
);

-- 학생 정보 삽입
INSERT INTO T_PERSON_INFO (student_id, name, age, major) 
VALUES ('20210034', '이상형', 21, '법학과');
INSERT INTO T_PERSON_INFO (student_id, name, age, major) 
VALUES ('20220011', '김건우', 24, '물리학과');
INSERT INTO T_PERSON_INFO (student_id, name, age, major) 
VALUES ('20240109', '전지훈', 20, '컴퓨터공학과');
INSERT INTO T_PERSON_INFO (student_id, name, age, major) 
VALUES ('20230002', '강순구', 21, '건축학과');


/*
2. 아래 내용을 참고하여 테이블을 생성하는 SQL을 작성하시오

테이블 이름 : board_list
속성
    board_list_id : 숫자, 최대 5자리 , Primary Key
    title : 글자, 내용 필수, 최대 100Byte
    content : 글자, 내용은 선택(필수x), 최대 2000byte
    writer : 글자, 내용 필수, 한글 기준 최대 20자리
    create_time : 숫자, 내용필수, 최대 13자리
*/

-- board_list 테이블 생성
CREATE TABLE board_list (
    board_list_id NUMBER(5) PRIMARY KEY,         
    title VARCHAR(100) NOT NULL,           
    content VARCHAR(2000),                
    writer VARCHAR(20) NOT NULL,           
    create_time DATE DEFAULT SYSDATE NOT NULL            
);



/*    
3. emp 테이블에는 detp 테이블의 deptno 컬럼을 FK로 가지고 있습니다.
두 테이블을 이용하여 emp의 급여(sal)이 2000 이상인 사원을 대상으로
사원번호(empno), 사원명(ename), 급여(sal), 부서명(dname), 부서위치(loc)를
각각 no, name ,salary, d_naem, location의 컬럼명으로 출력하는 SQL을 작성하시오.
(단, 급여(sal)는 높은 값부터 낮은 값 순으로 출력하세요)
*/

SELECT 
    e.empno AS no,           
    e.ename AS name,         
    e.sal AS salary,         
    d.dname AS d_name,      
    d.loc AS location        
FROM emp e
JOIN dept d ON e.deptno = d.deptno  
WHERE e.sal >= 2000           
ORDER BY e.sal DESC;              



-- 4. 1) DML에 의해 조작된 내용을 확정하고 반영하는 명령어를 작성하세요
COMMIT;

--    2) 트랜젝션을 취소하여 DML에 의해 조작된 내용을 되돌리는 명령어를 작성하세요.
ROLLBACK;


/*    
5. 현재 자신의 PC에 설치된 DBMS에 접속하여 쿼리들을 실행하고 있는 상태 입니다.
현재 접속 및 사용하고 있는 기준으로 다음 항목의 내용을 기술하세요.
*/
--1) DBMS 서비스명 
     orcl
--2) ip 주소
     fe80::137c:ba2d:ee2a:8e68%9
--3) port 번호
     0   
--4) 계정명
     scott
--5) 비밀번호
     tiger