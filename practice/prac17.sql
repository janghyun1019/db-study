--

--테이블 생성시, product_quiz 테이블명으로 생성

CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);

SELECT * FROM product_quiz;

SELECT 
    FLOOR(PRICE/10000)*10000 AS PRICE_GROUP  -- PRICE를 10,000원 단위로 내림하여 가격 그룹 생성
    ,COUNT(*) AS PRODUCTS                    -- 각 가격 그룹 내의 상품 개수를 계산
FROM product_quiz                            -- 데이터를 조회할 테이블 (product_quiz)
GROUP BY FLOOR(PRICE/10000)*10000            -- 10,000원 단위로 가격 그룹화
ORDER BY PRICE_GROUP;                        -- 가격 그룹을 오름차순으로 정렬

--선생님풀이
--그금액대 들어가는 갯수와 얼마대인지 알아야함

--0~9999
--10000~19999
--20000~29999
--30000~39999

--1.단순계산 먼저 해보기
    SELECT 0 PRICE_GROUP, COUNT(*) PRODUCTS
    FROM product_quiz
    WHERE price BETWEEN 0 AND 9999
        UNION ALL
    SELECT 10000, COUNT(*) 
    FROM product_quiz
    WHERE price BETWEEN 10000 AND 19999
        UNION ALL
    SELECT 20000, COUNT(*) 
    FROM product_quiz
    WHERE price BETWEEN 20000 AND 29999
        UNION ALL
    SELECT 30000, COUNT(*) 
    FROM product_quiz
    WHERE price BETWEEN 30000 AND 39999;

SELECT 30000 PRICE_GROUP,
        (SELECT COUNT(*) 
        FROM product_quiz
        WHERE price BETWEEN 30000 AND 39999) PRODUCTS
FROM dual;

--2. group by 로 잘 묶어보자

--만의 자릿수만 뽑아내면?;
SELECT TRUNC(price/10000), price/10000 
FROM product_quiz;
10000 1
9000  0
22000 2
15000 1
30000 3
17000 1

SELECT TRUNC(price/10000)*10000 PRICE_GROUP, COUNT(*) PRODUCTS
FROM product_quiz
GROUP BY TRUNC(price/10000)
ORDER BY price_group;

SELECT CASE
            WHEN price BETWEEN 0 AND 9999 THEN 0
            WHEN price BETWEEN 10000 AND 19999 THEN 10000
            WHEN price BETWEEN 20000 AND 29999 THEN 20000
            WHEN price BETWEEN 30000 AND 39999 THEN 30000
         END price_group,
         COUNT(*) PRODUCTS 
FROM product_quiz
GROUP BY CASE
            WHEN price BETWEEN 0 AND 9999 THEN 0
            WHEN price BETWEEN 10000 AND 19999 THEN 10000
            WHEN price BETWEEN 20000 AND 29999 THEN 20000
            WHEN price BETWEEN 30000 AND 39999 THEN 30000
         END
ORDER BY price_group         
;         
            
--자릿수 뽑아내는 개념이 있어야함

--3. GROUP BY... SUBQUERY를.. 써본다면?
SELECT * FROM product_quiz;

SELECT price price_group, COUNT(*) PRODUCTS
FROM (SELECT product_id, product_code, TRUNC(price/10000) * 10000 price
        FROM product_quiz)
GROUP BY price
ORDER BY price
;

SELECT price_group*10000 price_group, COUNT(*) PRODUCTS
FROM (SELECT product_id, product_code, TRUNC(price/10000) price_group
        FROM product_quiz)
GROUP BY price_group
ORDER BY price_group
;

SELECT price price_group, COUNT(*) PRODUCTS
FROM (SELECT TRUNC(price/10000) * 10000 price
        FROM product_quiz)
GROUP BY price
ORDER BY price
;

