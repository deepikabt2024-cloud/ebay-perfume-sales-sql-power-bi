-- CREATE DATABASE ebay_perfumes;
/*
CREATE TABLE ebay_mens_perfume(
brand VARCHAR(100),
title VARCHAR(100),
brand_type  VARCHAR(100),
price VARCHAR(30),
price_with_currency VARCHAR(30),
available VARCHAR(10),
available_text VARCHAR(100),
sold VARCHAR(10),
last_updated VARCHAR(100),
item_location VARCHAR(255)
);
*/
/*
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ebay_mens_perfume.csv'
INTO TABLE ebay_mens_perfume
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(brand, title, brand_type, price, price_with_currency,
 available, available_text,sold, last_updated, item_location);
 */
 /*
 CREATE TABLE ebay_womens_perfume(
brand VARCHAR(100),
title VARCHAR(100),
brand_type  VARCHAR(100),
price VARCHAR(30),
price_with_currency VARCHAR(30),
available VARCHAR(10),
available_text VARCHAR(100),
sold VARCHAR(10),
last_updated VARCHAR(100),
item_location VARCHAR(255)
 );
 */
 /*
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ebay_womens_perfume.csv'
INTO TABLE ebay_womens_perfume
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(brand, title, brand_type, price, price_with_currency,
 available, available_text,sold, last_updated, item_location);
 */
 
 -- SELECT * FROM ebay_mens_perfume;
 -- DESCRIBE ebay_mens_perfume;
 
 /*
 CREATE TABLE perfume_clean (
    brand          VARCHAR(100),
    title          VARCHAR(500),
    brand_type           VARCHAR(100),
    price          DECIMAL(10,2),
    sold           INT,
    available      INT,
    last_updated   DATETIME,
    item_location  VARCHAR(255)
);
*/

/*
ALTER TABLE perfume_clean
ADD COLUMN gender VARCHAR(10) FIRST;
*/
/*
SELECT DISTINCT brand
FROM ebay_mens_perfume
LIMIT 20;

SELECT
    brand AS raw_brand,
    TRIM(brand) AS cleaned_brand
FROM ebay_mens_perfume
LIMIT 10;
*/
/*
INSERT INTO perfume_clean (gender, brand)
SELECT
    'Men' AS gender,
    NULLIF(TRIM(brand), '') AS brand
FROM ebay_mens_perfume;


SELECT brand, COUNT(*)
FROM perfume_clean
GROUP BY brand
ORDER BY COUNT(*) DESC
LIMIT 10;
*/
--  title --
/*
SELECT title
FROM ebay_mens_perfume
LIMIT 5;
*/
/*
SELECT
    title AS raw_title,
    NULLIF(TRIM(title), '') AS cleaned_title
FROM ebay_mens_perfume
LIMIT 5;
*/
/*
INSERT INTO perfume_clean (gender, brand, title)
SELECT
    'Men',
    NULLIF(TRIM(brand), ''),
    NULLIF(TRIM(title), '')
FROM ebay_mens_perfume;
*/
/*
SELECT title
FROM perfume_clean
WHERE title IS NULL
LIMIT 5;
*/
-- brand_type --
/*
SELECT DISTINCT brand_type
FROM ebay_mens_perfume;
*/
/*
SELECT
    brand_type AS raw_type,
    CASE
        WHEN LOWER(brand_type) IN ('edp','eau de parfum') THEN 'Eau de Parfum'
        WHEN LOWER(brand_type) IN ('edt','eau de toilette') THEN 'Eau de Toilette'
        WHEN LOWER(brand_type) = 'cologne' THEN 'Cologne'
        WHEN LOWER(brand_type) = 'perfume' THEN 'Perfume'
        ELSE NULLIF(TRIM(brand_type), '')
    END AS cleaned_type
FROM ebay_mens_perfume
LIMIT 10;
*/
/*
INSERT INTO perfume_clean (gender, brand, title, brand_type)
SELECT
    'Men',
    NULLIF(TRIM(brand), ''),
    NULLIF(TRIM(title), ''),
    CASE
        WHEN LOWER(brand_type) IN ('edp','eau de parfum') THEN 'Eau de Parfum'
        WHEN LOWER(brand_type) IN ('edt','eau de toilette') THEN 'Eau de Toilette'
        WHEN LOWER(brand_type) = 'cologne' THEN 'Cologne'
        WHEN LOWER(brand_type) = 'perfume' THEN 'Perfume'
        ELSE NULLIF(TRIM(brand_type), '')
    END
FROM ebay_mens_perfume;
*/
/*
SELECT
    brand_type AS raw_brand_type,
    CASE
        WHEN brand_type IS NULL THEN NULL
        WHEN TRIM(brand_type) IN ('', '/', 'N/A', 'n/a', 'NA', 'Y') THEN NULL
        WHEN LOWER(brand_type) IN ('edp','eau de parfum') THEN 'Eau de Parfum'
        WHEN LOWER(brand_type) IN ('edt','eau de toilette') THEN 'Eau de Toilette'
        WHEN LOWER(brand_type) = 'cologne' THEN 'Cologne'
        WHEN LOWER(brand_type) = 'perfume' THEN 'Perfume'
        ELSE TRIM(brand_type)
    END AS cleaned_brand_type
FROM ebay_mens_perfume
LIMIT 25;
*/

-- SET SQL_SAFE_UPDATES = 0;
/*
UPDATE perfume_clean
SET brand_type =
    CASE
        WHEN brand_type IS NULL THEN NULL
        WHEN TRIM(brand_type) IN ('', '/', 'N/A', 'n/a', 'NA', 'Y') THEN NULL
        WHEN LOWER(brand_type) LIKE '%extrait%' THEN 'Extrait de Parfum'
        WHEN LOWER(brand_type) LIKE '%parfum%' THEN 'Eau de Parfum'
        WHEN LOWER(brand_type) LIKE '%toilette%' THEN 'Eau de Toilette'
        WHEN LOWER(brand_type) LIKE '%cologne%' THEN 'Cologne'
        ELSE 'Other'
    END;
*/
/*
SELECT brand_type, COUNT(*)
FROM perfume_clean
GROUP BY brand_type
ORDER BY COUNT(*) DESC;
*/
-- price --
/*
SELECT DISTINCT price
FROM ebay_mens_perfume
LIMIT 20;
*/
/*
SELECT
    price AS raw_price,
    CAST(price AS DECIMAL(10,2)) AS cleaned_price
FROM ebay_mens_perfume
LIMIT 10;
*/
/*
UPDATE perfume_clean pc
JOIN ebay_mens_perfume em
    ON pc.title = em.title
   AND pc.gender = 'Men'
SET pc.price = CAST(em.price AS DECIMAL(10,2));
*/
/*

-- TRUNCATE TABLE perfume_clean;
/*
INSERT INTO perfume_clean (
    gender, brand, title, brand_type, price, sold, available
)
SELECT
    'Men',
    TRIM(brand),
    TRIM(title),
    brand_type,
    CAST(NULLIF(price, '') AS DECIMAL(10,2)),
    CAST(NULLIF(sold, '') AS UNSIGNED),
    CAST(NULLIF(available, '') AS UNSIGNED)
FROM ebay_mens_perfume;

SELECT gender, COUNT(*) 
FROM perfume_clean
GROUP BY gender;
*/
/*
-- available --
SELECT DISTINCT available
FROM ebay_mens_perfume
LIMIT 20;
*/

-- TRUNCATE TABLE perfume_clean;
/*
INSERT INTO perfume_clean (
    gender, brand, title, brand_type, price, sold, available
)
SELECT
    'Men',
    TRIM(brand),
    TRIM(title),
    brand_type,
    CAST(NULLIF(price,'') AS DECIMAL(10,2)),
    CAST(NULLIF(sold,'') AS UNSIGNED),
    CAST(NULLIF(available,'') AS UNSIGNED)
FROM ebay_mens_perfume;
*/
/*
SELECT COUNT(*) AS total_rows,
       COUNT(available) AS non_null_available
FROM perfume_clean
WHERE gender = 'Men';
*/

-- sold --
/*
SELECT DISTINCT sold
FROM ebay_mens_perfume
ORDER BY sold;
*/
/*
UPDATE perfume_clean
SET sold = NULL
WHERE sold = '' OR sold IS NULL;
*/
/*
SELECT sold
FROM perfume_clean
WHERE sold IS NOT NULL
AND sold NOT REGEXP '^[0-9]+$';
*/

/*
SELECT
    COUNT(*) AS total_rows,
    COUNT(sold) AS non_null_sold,
    MIN(sold) AS min_sold,
    MAX(sold) AS max_sold
FROM perfume_clean
WHERE gender = 'Men';
*/

-- last updated --
/*
SELECT DISTINCT last_updated
FROM ebay_mens_perfume
LIMIT 20;
*/
/*
UPDATE perfume_clean
SET last_updated =
    STR_TO_DATE(
        NULLIF(SUBSTRING_INDEX(last_updated, ' PDT', 1), ''),
        '%M %d, %Y %H:%i:%s'
    )
WHERE gender = 'Men';
*/
/*
ALTER TABLE perfume_clean
MODIFY last_updated DATETIME;
*/
/*
SELECT
    COUNT(*) AS total_rows,
    COUNT(last_updated) AS non_null_dates,
    MIN(last_updated) AS earliest,
    MAX(last_updated) AS latest
FROM perfume_clean
WHERE gender = 'Men';
*/
/*
SELECT
    COUNT(*) AS total_rows,
    COUNT(item_location) AS non_null_locations
FROM perfume_clean
WHERE gender = 'Men';
*/
/*
SELECT gender, COUNT(*) 
FROM perfume_clean
GROUP BY gender;
*/
/*
INSERT INTO perfume_clean (
    gender,
    brand,
    title,
    brand_type,
    price,
    sold,
    available,
    item_location
)
SELECT
    'Women' AS gender,
    TRIM(brand),
    TRIM(title),
    brand_type,
    NULLIF(price,'') + 0,
    NULLIF(sold,'') + 0,
    NULLIF(available,'') + 0,
    TRIM(item_location)
FROM ebay_womens_perfume;
*/
/*
SELECT gender, COUNT(*) 
FROM perfume_clean
GROUP BY gender;
*/
-- SET SQL_SAFE_UPDATES = 0;
/*
UPDATE perfume_clean
SET brand_type =
    CASE
        WHEN brand_type IS NULL THEN NULL
        WHEN TRIM(brand_type) IN ('', '/', 'N/A', 'n/a', 'NA', 'Y', '1','3pc') THEN NULL

        WHEN LOWER(brand_type) IN ('edp', 'eau de parfum') 
            THEN 'Eau de Parfum'

        WHEN LOWER(brand_type) IN ('edt', 'eau de toilette') 
            THEN 'Eau de Toilette'

        WHEN LOWER(brand_type) = 'cologne' 
            THEN 'Cologne'

        WHEN LOWER(brand_type) = 'perfume' 
            THEN 'Perfume'

        ELSE TRIM(brand_type)
    END;
*/
/*
UPDATE perfume_clean
SET brand_type = 
    CASE
        WHEN LOWER(brand_type) LIKE '%edp%' THEN 'Eau de Parfum'
        WHEN LOWER(brand_type) LIKE '%edt%' THEN 'Eau de Toilette'
        ELSE NULL
    END
WHERE LOWER(brand_type) REGEXP '[0-9]+ *p';
*/

-- VERIFICATION --
/*
SELECT brand_type, COUNT(*)
FROM perfume_clean
GROUP BY brand_type
ORDER BY COUNT(*) DESC;
*/

-- FINAL CHECK -- 
/*
SELECT gender, COUNT(*) AS total_rows
FROM perfume_clean
GROUP BY gender;
*/
/*
SELECT
    COUNT(*) AS total_rows,
    SUM(brand IS NULL) AS null_brand,
    SUM(title IS NULL) AS null_title,
    SUM(price IS NULL) AS null_price
FROM perfume_clean;
*/
/*
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    MIN(sold) AS min_sold,
    MAX(sold) AS max_sold,
    MIN(available) AS min_available,
    MAX(available) AS max_available
FROM perfume_clean;
*/
/*
SELECT brand_type, COUNT(*)
FROM perfume_clean
GROUP BY brand_type
ORDER BY COUNT(*) DESC;
*/
/*
SELECT DISTINCT gender
FROM perfume_clean;
*/
/*
SELECT item_location, COUNT(*)
FROM perfume_clean
GROUP BY item_location
ORDER BY COUNT(*) DESC
LIMIT 10;
*/
/*
SELECT
    COUNT(*) AS total_rows,
    COUNT(last_updated) AS valid_dates
FROM perfume_clean;
*/
/*
SELECT title, gender, COUNT(*)
FROM perfume_clean
GROUP BY title, gender
HAVING COUNT(*) > 1;
*/
