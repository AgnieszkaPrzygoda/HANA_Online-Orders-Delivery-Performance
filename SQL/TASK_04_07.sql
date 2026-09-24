Test Dimension View

-- Query dimension - returns all rows as-is
SELECT * FROM "CV_PRODUCTS_DIM";

-- Try to aggregate (you control aggregation in query)
SELECT CATEGORY, COUNT(*) AS PRODUCT_COUNT
FROM "CV_PRODUCTS_DIM"
GROUP BY CATEGORY;

Test Cube View

-- Query cube - automatically aggregates measures
SELECT * FROM "CV_PRODUCTS_CUBE";

-- Aggregation is automatic based on grouping
SELECT CATEGORY, SUM(UNIT_PRICE) AS TOTAL_PRICE
FROM "CV_PRODUCTS_CUBE"
GROUP BY CATEGORY;