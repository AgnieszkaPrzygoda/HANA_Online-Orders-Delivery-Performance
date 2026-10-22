-- VALIDATION TESTS FOR FINAL PROJECT

-- Order-Level Aggregation
-- Purpose: Compare line items and unique orders.
-- Check that total sales remain unchanged after aggregation.
-- Expected result: 77 line items, 66 unique orders,
-- and total sales of 25,700.82 EUR in both sources.
SELECT
    (SELECT COUNT(*)
     FROM FACT_ORDERS) AS TOTAL_LINE_ITEMS,

    (SELECT COUNT(DISTINCT ORDER_ID)
     FROM FACT_ORDERS) AS UNIQUE_ORDERS,

    (SELECT COUNT(*)
     FROM CAC_I_ORDERS_ORDER_LEVEL) AS CV_ORDER_COUNT,

    (SELECT SUM(AMOUNT)
     FROM FACT_ORDERS) AS FACT_TOTAL_SALES,

    (SELECT SUM(AMOUNT)
     FROM CAC_I_ORDERS_ORDER_LEVEL) AS CV_TOTAL_SALES
FROM DUMMY;


-- Delivery Performance and SLA Status
-- Purpose: Check the number of orders and delivery times by SLA status.
-- Expected result: 66 orders in total (On Time, Late, Not Delivered).
-- Not Delivered orders should have NULL delivery days.
SELECT
    SLA_STATUS,
    COUNT(*) AS ORDER_COUNT,
    MIN(DELIVERY_DAYS) AS MIN_DELIVERY_DAYS,
    MAX(DELIVERY_DAYS) AS MAX_DELIVERY_DAYS,
    AVG(DELIVERY_DAYS) AS AVG_DELIVERY_DAYS
FROM V_I_ORDER_ENRICHED
GROUP BY SLA_STATUS
ORDER BY SLA_STATUS;


-- Overall Delivery KPIs
-- Purpose: Check the total number of orders, total order value,
-- and average delivery time in CV_DELIVERY_CUBE.
-- Expected result: 66 orders, 25,700.82 EUR,
-- and an average delivery time of about 4.23 days.
SELECT
    SUM(ORDER_COUNT) AS TOTAL_ORDERS,
    SUM(ORDER_VALUE) AS TOTAL_ORDER_VALUE,
    AVG(DELIVERY_DAYS) AS AVG_DELIVERY_DAYS
FROM CAC_R_DELIVERY_PERFORMANCE;


-- Carrier Performance
-- Purpose: Check order count, total order value,
-- and average delivery time for each carrier.
-- Expected result: 4 carriers, 66 orders in total,
-- and total order value of 25,700.82 EUR.
SELECT
    CARRIER_NAME,
    SUM(ORDER_COUNT) AS TOTAL_ORDERS,
    SUM(ORDER_VALUE) AS TOTAL_ORDER_VALUE,
    AVG(DELIVERY_DAYS) AS AVG_DELIVERY_DAYS
FROM CAC_R_DELIVERY_PERFORMANCE
GROUP BY CARRIER_NAME
ORDER BY CARRIER_NAME;


-- Region and Year Analysis
-- Purpose: Check if the Cube can analyze orders
-- by customer region and order year.
-- Expected result: Data grouped by region and year.
SELECT
    REGION,
    YEAR,
    SUM(ORDER_COUNT) AS TOTAL_ORDERS,
    SUM(ORDER_VALUE) AS TOTAL_ORDER_VALUE
FROM CAC_R_DELIVERY_PERFORMANCE
GROUP BY REGION, YEAR
ORDER BY YEAR, REGION;


-- Orders Exceeding SLA (Late Deliveries)
-- Business Purpose:
-- Identify orders delivered after the expected delivery date.
-- Show the number of delay days and the order value.
-- This helps identify the most delayed orders.
SELECT
    ORDER_ID,
    ORDER_DATE,
    EXPECTED_DELIVERY_DATE,
    DELIVERY_DATE,
    SLA_STATUS,
    DAYS_BETWEEN(
        EXPECTED_DELIVERY_DATE,
        DELIVERY_DATE
    ) AS DELAY_DAYS,
    ORDER_VALUE
FROM "V_I_ORDER_ENRICHED"
WHERE SLA_STATUS = 'Late'
ORDER BY DELAY_DAYS DESC;