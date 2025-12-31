/*
ALTER TABLE perfume_clean
ADD COLUMN consolidated_brand VARCHAR(100);
*/
-- SET SQL_SAFE_UPDATES = 0;
/*
UPDATE perfume_clean
SET consolidated_brand =
    CASE 
        WHEN brand IS NULL OR TRIM(brand) = '' 
            THEN 'Unknown'

        WHEN LOWER(brand) REGEXP 'unbranded|as show|as shown|generic|cologne|parfum|asst' 
            THEN 'Non-Brand / Generic'

        WHEN LOWER(brand) LIKE '%dolce%gabbana%' 
            THEN 'Dolce & Gabbana'

        WHEN LOWER(brand) LIKE '%ralph%lauren%' 
            THEN 'Ralph Lauren'

        WHEN LOWER(brand) LIKE '%armani%' 
            THEN 'Giorgio Armani'

        WHEN LOWER(brand) LIKE '%yves%saint%laurent%' 
             OR LOWER(brand) = 'ysl' 
            THEN 'Yves Saint Laurent'

        WHEN LOWER(brand) LIKE '%victoria%secret%' 
            THEN 'Victoria’s Secret'

        ELSE TRIM(brand)
    END;
*/
-- SELECT * FROM perfume_clean
/*
CREATE VIEW top_brand AS
SELECT 
    consolidated_brand,
    SUM(sold) AS total_units_sold
FROM perfume_clean
GROUP BY consolidated_brand
ORDER BY total_units_sold DESC
LIMIT 5;
*/ -- SELECT * FROM top_brand;
/*
SELECT
    consolidated_brand,
    title,
    sold,
    available,
    CASE
        WHEN sold < (SELECT AVG(sold) FROM perfume_clean)
         AND available > (SELECT AVG(available) FROM perfume_clean)
        THEN 'High Risk'
        ELSE 'Normal'
    END AS risk_status
FROM perfume_clean;
*/
/*
 CREATE VIEW high_risk_of AS
SELECT
    consolidated_brand,
    SUM(sold) AS total_sold,
    SUM(available) AS total_available,
    ROUND(
        (SUM(sold) / NULLIF(SUM(sold) + SUM(available), 0)) * 100,
        2
    ) AS sell_through_percentage
FROM perfume_clean
GROUP BY consolidated_brand
HAVING
    SUM(sold) < (
        SELECT AVG(brand_sold)
        FROM (
            SELECT SUM(sold) AS brand_sold
            FROM perfume_clean
            GROUP BY consolidated_brand
        ) t1
    )
    AND
    SUM(available) > (
        SELECT AVG(brand_available)
        FROM (
            SELECT SUM(available) AS brand_available
            FROM perfume_clean
            GROUP BY consolidated_brand
        ) t2
    )
ORDER BY sell_through_percentage ASC
LIMIT 5; 
 */ -- select * from high_risk_of;
/*
CREATE VIEW sell_through_effi AS
SELECT
    consolidated_brand,
    SUM(sold) AS total_units_sold,
    SUM(available) AS total_units_available,
    ROUND(
        (SUM(sold) / NULLIF(SUM(sold) + SUM(available), 0)) * 100,
        2
    ) AS sell_through_pct
FROM perfume_clean
GROUP BY consolidated_brand
HAVING SUM(sold) > 0
ORDER BY sell_through_pct DESC
LIMIT 5;
*/

 -- SET SQL_SAFE_UPDATES = 0;
/*
UPDATE perfume_clean
SET item_location = 'Unknown'
WHERE item_location IS NULL;
*/
/*
UPDATE perfume_clean
SET item_location = 'Unknown'
WHERE brand_type IS NULL;
*/
-- preferred location by totall units sold
/*
CREATE VIEW preferred_location AS
SELECT
    item_location,
    SUM(sold) AS total_units_sold
FROM perfume_clean
WHERE item_location IS NOT NULL
GROUP BY item_location
ORDER BY total_units_sold DESC
LIMIT 5;
*/
/*
CREATE VIEW item_location_per_revenue AS
SELECT
    item_location,
    SUM(sold * price) AS total_revenue
FROM perfume_clean
GROUP BY item_location
ORDER BY total_revenue DESC
LIMIT 5;
*/ -- select * from item_location_per_revenue

-- PREFERRED GENDER CATEGORY
/*
CREATE VIEW category_per_units AS
SELECT
    gender,
    SUM(sold) AS total_units_sold
FROM perfume_clean
GROUP BY gender
ORDER BY total_units_sold DESC;
*/ -- select * from category_per_units
/*
CREATE VIEW category_per_revenue AS
SELECT
    gender,
    SUM(sold * price) AS total_revenue
FROM perfume_clean
GROUP BY gender
ORDER BY total_revenue DESC;
*/ -- select* from category_per_revenue;