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
     FROM CV_ORDERS_ORDER_LEVEL) AS CV_ORDER_COUNT,

    (SELECT SUM(AMOUNT)
     FROM FACT_ORDERS) AS FACT_TOTAL_SALES,

    (SELECT SUM(AMOUNT)
     FROM CV_ORDERS_ORDER_LEVEL) AS CV_TOTAL_SALES
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
FROM CV_ORDER_ENRICHED
GROUP BY SLA_STATUS
ORDER BY SLA_STATUS;