-- Verifies total sales and compares them with all restricted sales measures
SELECT
    "TOTAL_SALES",
    "DELIVERED_SALES",
    "FRAGILE_PRODUCT_SALES",
    "ON_TIME_SALES"
FROM "CV_SALES_WITH_RESTRICTIONS";


-- Verifies how much of each carrier's total sales value comes from delivered orders
SELECT
    "CARRIER_NAME",
    "TOTAL_SALES",
    "DELIVERED_SALES",
    CAST(("DELIVERED_SALES" / "TOTAL_SALES") * 100 AS DECIMAL(5,2))
        AS "DELIVERED_SALES_PCT"
FROM "CV_SALES_WITH_RESTRICTIONS"
WHERE "TOTAL_SALES" > 0
ORDER BY "DELIVERED_SALES_PCT" DESC;


-- Verifies the sales value of fragile products in each region
SELECT
    "REGION",
    "TOTAL_SALES",
    "FRAGILE_PRODUCT_SALES",
    CAST(("FRAGILE_PRODUCT_SALES" / "TOTAL_SALES") * 100 AS DECIMAL(5,2))
        AS "FRAGILE_SALES_PCT"
FROM "CV_SALES_WITH_RESTRICTIONS"
WHERE "TOTAL_SALES" > 0
ORDER BY "FRAGILE_SALES_PCT" DESC;


-- Verifies and compares delivered and on-time sales value across regions
-- ON_TIME_SALES includes only delivered orders completed on or before the expected delivery date
SELECT
    "REGION",
    "DELIVERED_SALES",
    "ON_TIME_SALES"
FROM "CV_SALES_WITH_RESTRICTIONS"
ORDER BY "ON_TIME_SALES" DESC;