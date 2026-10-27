-- Test 1: View top 2 products overall
SELECT * FROM "CV_TOP_PRODUCTS_RANKED"
ORDER BY RANK;

-- Test 2: See top 2 products per category
SELECT CATEGORY, PRODUCT_NAME, TOTAL_SALES, RANK
FROM "CV_TOP_PRODUCTS_RANKED"
ORDER BY CATEGORY, RANK;

-- Test 3: Check that only top N are returned
SELECT COUNT(*) AS TOTAL_RECORDS
FROM "CV_TOP_PRODUCTS_RANKED";
-- Should return 2 (or 2 * number of categories if partitioned)

select category from "CV_TOP_PRODUCTS_RANKED"
group by category;