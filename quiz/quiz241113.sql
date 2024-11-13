/*
#퀴즈

MERGE DATA_1 -> COLC
MERGE DATA_2 -> COLC
날짜 기준으로 각 A업체 B업체 여부를 둘다 확인!

외부에서 일일 배치로 전달받아서 DB에 저장하는 데이터가 있다.

A업체에서 받은 데이터는 TABLE_DATA_1 에 저장하고
B업체에서 받은 데이터는 TABLE_DATA_2 에 저장한다.

각각 저장된 데이터와 들어온 날짜가 저장된다.
(no순번에 맞춰서 들어오고, 데이터가 들어왔다고 가정한다)
*/


CREATE TABLE TABLE_DATA_1
(
no number(10),
create_date DATE
);

CREATE TABLE TABLE_DATA_2
(
no number(10),
create_date DATE
);

/*
이때, A업체 B업체로 부터 각각 들어오기 때문에
(추후 C, D 업체등 확장 가능)
언제 들어왔는지 확인목적으로 데이터 취합여부를 체크하는
TABLE_COLC 를 만들었다.
*/

CREATE TABLE TABLE_COLC
(
std_date DATE,
CHECK_DATA1 VARCHAR2(6),
CHECK_DATA2 VARCHAR2(6)
);

/*
각 날짜를 기준으로 데이터가 들어왔으면 'Y' 로 아직 안들어왔으면 'N'으로 표기한다.
CHECK_DATA1 는 A업체에서 들어왔는지 여부
CHECK_DATA2 는 B업체에서 들어왔는지 여부
*/

INSERT INTO TABLE_DATA_1 VALUES (1, '2023-04-01');
INSERT INTO TABLE_DATA_1 VALUES (2, '2023-04-02');
INSERT INTO TABLE_DATA_1 VALUES (3, '2023-04-03');
INSERT INTO TABLE_DATA_1 VALUES (4, '2023-04-04');

INSERT INTO TABLE_DATA_2 VALUES (1, '2023-04-02');
INSERT INTO TABLE_DATA_2 VALUES (2, '2023-04-03');
INSERT INTO TABLE_DATA_2 VALUES (3, '2023-04-04');
INSERT INTO TABLE_DATA_2 VALUES (4, '2023-04-05');

/*
각 업체별로 TABLE_COLC에 취합(병합) 하는 쿼리를 작성하세요.
작성 후 A업체와 B업체의 수신 여부가 취합되야 합니다.
*/
SELECT * FROM TABLE_DATA_1;

SELECT * FROM TABLE_DATA_2;

SELECT * FROM TABLE_COLC;


-- A업체의 데이터 병합
MERGE INTO TABLE_COLC colc
USING (SELECT DISTINCT create_date, 'Y' AS check_data1
    FROM TABLE_DATA_1 ) data1
ON (colc.std_date = data1.create_date)
WHEN MATCHED THEN 
    UPDATE SET colc.check_data1 = data1.check_data1
WHEN NOT MATCHED THEN 
    INSERT (colc.std_date, colc.check_data1, colc.check_data2)
    VALUES (data1.create_date, data1.check_data1, 'N');

-- B업체의 데이터 병합
MERGE INTO TABLE_COLC colc
USING (SELECT DISTINCT create_date, 'Y' AS check_data2
    FROM TABLE_DATA_2) data2
ON (colc.std_date = data2.create_date)
WHEN MATCHED THEN 
    UPDATE SET colc.check_data2 = data2.check_data2
WHEN NOT MATCHED THEN 
    INSERT (colc.std_date, colc.check_data1, colc.check_data2)
    VALUES (data2.create_date, 'N', data2.check_data2);


SELECT * FROM TABLE_COLC
ORDER BY std_date;




