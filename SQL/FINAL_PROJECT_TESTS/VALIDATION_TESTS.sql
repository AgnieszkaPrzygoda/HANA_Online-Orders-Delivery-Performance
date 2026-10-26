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


-- Key KPI Queries

-- Key Query 1: On-Time Delivery Rate by Carrier (Last 30 Days)
-- Purpose: Compare carrier performance for recent orders.

SELECT
    CARRIER_NAME,
    SUM(ON_TIME_ORDERS) AS ON_TIME_ORDERS,
    SUM(DELIVERED_ORDERS) AS DELIVERED_ORDERS,
    ROUND(
        100.0 * SUM(ON_TIME_ORDERS)
        / NULLIF(SUM(DELIVERED_ORDERS), 0),
        2
    ) AS ON_TIME_DELIVERY_RATE
FROM CAC_R_DELIVERY_PERFORMANCE
WHERE ORDER_DATE >= ADD_DAYS(CURRENT_DATE, -30)
  AND ORDER_DATE <= CURRENT_DATE
GROUP BY CARRIER_NAME
ORDER BY ON_TIME_DELIVERY_RATE DESC;

-- Key Query 2: Average Delivery Time by Service Level
-- Purpose: Compare average delivery time across service levels.
SELECT
    SERVICE_LEVEL,
    SUM(ORDER_COUNT) AS TOTAL_ORDERS,
    ROUND(AVG(DELIVERY_DAYS), 2) AS AVG_DELIVERY_DAYS
FROM CAC_R_DELIVERY_PERFORMANCE
GROUP BY SERVICE_LEVEL
ORDER BY AVG_DELIVERY_DAYS;

-- Key Query 3: Top 5 Orders Exceeding SLA (Late Deliveries)
-- Purpose: Identify late deliveries and their delay days.
SELECT
    ORDER_ID,
    ORDER_DATE,
    EXPECTED_DELIVERY_DATE,
    DELIVERY_DATE,
    DELAY_DAYS,
    ORDER_VALUE
FROM V_I_ORDER_ENRICHED
WHERE SLA_STATUS = 'Late'
ORDER BY DELAY_DAYS DESC
LIMIT 5;

-- Key Query 4: Carrier Performance Ranking by Region
-- Purpose: Rank carriers by on-time delivery rate in each region.
SELECT
    REGION,
    CARRIER_NAME,
    ON_TIME_DELIVERY_RATE,
    CARRIER_RANK
FROM CAC_R_CARRIER_RANKING
ORDER BY REGION, CARRIER_RANK, CARRIER_NAME;