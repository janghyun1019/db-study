-- dml02 merge

-- 신발가게 날짜별 매출

DROP TABLE COMP_M;  --삭제
CREATE TABLE SHOE_M
(
    w_date DATE
    ,s_code NUMBER(3) --매장고유코드
    ,sales NUMBER(10)
);

DROP TABLE CLOT_M;
-- 옷가게 날짜별 매출
CREATE TABLE CLOT_M
(
    w_date DATE
    ,s_code NUMBER(3) --매장고유코드
    ,sales NUMBER(10)
);

--본사 전체 매출
CREATE TABLE COMP_M
(
    w_date DATE
    ,s_code NUMBER(3) --매장고유코드
    ,sales NUMBER(10)
);

--본사 전체 매출

DROP TABLE COMP_M;
CREATE TABLE COMP_M
(
    w_date DATE
    ,s_code NUMBER(3) --매장고유코드
    ,sales NUMBER(10)
    ,type VARCHAR2(2) --가게구분 코드 'C' 옷가게 ,'S' 신발가게
);

--하나의 가게
--날짜별 여러가게
--날짜구분 코드

INSERT ALL
INTO SHOE_M VALUES (TO_DATE('2024-11-01'), 1, 5000)
INTO SHOE_M VALUES (TO_DATE('2024-11-02'), 1, 10000)
INTO SHOE_M VALUES (TO_DATE('2024-11-03'), 1, 20000)
SELECT * FROM dual;

INSERT ALL
INTO CLOT_M VALUES (TO_DATE('2024-11-01'), 2, 20000)
INTO CLOT_M VALUES (TO_DATE('2024-11-02'), 2, 29000)
INTO CLOT_M VALUES (TO_DATE('2024-11-03'), 2, 100000)
SELECT * FROM dual;

UPDATE SHOE_M
SET sales = 13000
WHERE w_date = '2024-11-02';

UPDATE SHOE_M
SET sales = 9000
WHERE w_date = '2024-11-02';

INSERT ALL
INTO CLOT_M VALUES (TO_DATE('2024-11-04'), 50, 5000)
INTO CLOT_M VALUES (TO_DATE('2024-11-05'), 50, 10000)
INTO CLOT_M VALUES (TO_DATE('2024-11-06'), 50, 20000)
SELECT * FROM dual;

UPDATE CLOT_M
SET sales = 64000
WHERE w_date = '2024-11-06';

SELECT * FROM SHOE_M;

SELECT * FROM CLOT_M;

SELECT * FROM COMP_M;

--DELETE FROM COMP_M;


INSERT INTO COMP_M
SELECT * FROM SHOE_M;

INSERT INTO COMP_M
SELECT * FROM CLOT_M;

SELECT s_code, SUM(Sales)
FROM comp_m
GROUP BY s_code;

SELECT SUM(Sales)
FROM comp_m
WHERE TO_CHAR(w_date, 'MM') = 11;

--하나의 가게 + 날짜 중복X
MERGE INTO comp_m m
USING SHOE_M s
ON (m.w_date = s.w_date)
WHEN MATCHED THEN  -- 조건에 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN --조건이 일치하는게 없으면 
    INSERT VALUES (s.w_date, s.s_code, s.sales);
    
SELECT * FROM COMP_M;    

MERGE INTO comp_m m
USING CLOT_M s
ON (m.w_date = s.w_date)
WHEN MATCHED THEN  -- 조건에 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN --조건이 일치하는게 없으면 
    INSERT VALUES (s.w_date, s.s_code, s.sales);
    
--날짜별 여러가게

--날짜별 데이터 추가

INSERT ALL
INTO SHOE_M VALUES (TO_DATE('2024-11-01'), 2, 15000)
INTO SHOE_M VALUES (TO_DATE('2024-11-02'), 2, 20000)
INTO SHOE_M VALUES (TO_DATE('2024-11-03'), 2, 80000)
SELECT * FROM dual;

INSERT ALL
INTO CLOT_M VALUES (TO_DATE('2024-11-04'), 60, 28000)
INTO CLOT_M VALUES (TO_DATE('2024-11-05'), 60, 46000)
INTO CLOT_M VALUES (TO_DATE('2024-11-06'), 60, 156000)
SELECT * FROM dual;

SELECT * FROM SHOE_M;

SELECT * FROM CLOT_M;

SELECT * FROM COMP_M;

MERGE INTO comp_m m
USING SHOE_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code)
WHEN MATCHED THEN  -- 조건에 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN --조건이 일치하는게 없으면 
    INSERT VALUES (s.w_date, s.s_code, s.sales);
    
SELECT * FROM COMP_M;    

MERGE INTO comp_m m
USING CLOT_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code)
WHEN MATCHED THEN  -- 조건에 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN --조건이 일치하는게 없으면 
    INSERT VALUES (s.w_date, s.s_code, s.sales);

SELECT s_code, SUM(Sales)
FROM comp_m
GROUP BY s_code;

SELECT w_date, SUM(Sales)
FROM comp_m
GROUP BY w_date
ORDER BY w_date;

SELECT SUM(Sales)
FROM comp_m
WHERE TO_CHAR(w_date, 'MM') = 11;


UPDATE CLOT_M
SET sales = 94000
WHERE w_date = '2024-11-06';


--가게구분 코드

SELECT *
FROM comp_m;  --신발가게 매출만 or 옷가게 매출

MERGE INTO comp_m m
USING SHOE_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code)
WHEN MATCHED THEN  -- 조건에 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN --조건이 일치하는게 없으면 
    INSERT VALUES (s.w_date, s.s_code, s.sales, 'S');
       
MERGE INTO comp_m m
USING CLOT_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code)
WHEN MATCHED THEN  -- 조건에 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN --조건이 일치하는게 없으면 
    INSERT VALUES (s.w_date, s.s_code, s.sales, 'C');

SELECT type, s_code, SUM(sales)
FROM comp_m
GROUP BY type, s_code; 




