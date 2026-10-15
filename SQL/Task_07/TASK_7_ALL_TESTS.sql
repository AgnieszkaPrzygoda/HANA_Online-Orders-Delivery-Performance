-- Task1: Scalar function
-- Late Delivery: Checks if the function returns a positive number when the delivery is late.
SELECT
    'Late delivery' AS TEST_CASE,
    "FN_DELIVERY_DELAY_DAYS"(
        TO_DATE('2024-01-17'),
        TO_DATE('2024-01-18')
    ) AS DELAY_DAYS
FROM DUMMY

UNION ALL

-- On-time Delivery: Checks if the function returns 0 when the delivery date matches the expected date.
SELECT
    'On-time delivery',
    "FN_DELIVERY_DELAY_DAYS"(
        TO_DATE('2022-05-15'),
        TO_DATE('2022-05-15')
    )
FROM DUMMY

UNION ALL

-- Early Delivery: Checks if the function returns 0 when the delivery arrives before the expected date.
SELECT
    'Early delivery',
    "FN_DELIVERY_DELAY_DAYS"(
        TO_DATE('2023-04-17'),
        TO_DATE('2023-04-15')
    )
FROM DUMMY

UNION ALL

-- Missing Delivery Date: Checks if the function returns NULL when the actual delivery date is missing.
SELECT
    'Missing delivery date',
    "FN_DELIVERY_DELAY_DAYS"(
        TO_DATE('2025-05-30'),
        CAST(NULL AS DATE)
    )
FROM DUMMY;


-- Real Order Data: Tests the function using the FACT_ORDERS table to calculate delivery delays for actual orders.
SELECT
    ORDER_ID,
    LINE_ITEM_ID,
    EXPECTED_DELIVERY_DATE,
    DELIVERY_DATE,
    DELIVERY_STATUS,
    "FN_DELIVERY_DELAY_DAYS"(
        EXPECTED_DELIVERY_DATE,
        DELIVERY_DATE
    ) AS DELAY_DAYS
FROM FACT_ORDERS
ORDER BY ORDER_ID, LINE_ITEM_ID;


-- Task2: Stored Procedure: UPDATE_DELIVERY_STATUS - test cases

-- Test1: Successful delivery status update
-- Update Order 29, Line Item 1 from 'Shipped' to 'Delivered'
-- using the actual delivery date 2025-06-02.
CALL "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."UPDATE_DELIVERY_STATUS"(
    29,
    1,
    TO_DATE('2025-06-02'),
    ?,
    ?
);

-- Checking updated data
SELECT ORDER_ID, LINE_ITEM_ID, DELIVERY_STATUS, DELIVERY_DATE
FROM FACT_ORDERS
WHERE ORDER_ID = 29
  AND LINE_ITEM_ID = 1;
  
  
-- Test2 :Order already delivered
-- Check that an already delivered order is not updated again.
CALL "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."UPDATE_DELIVERY_STATUS"(
    29,
    1,
    TO_DATE('2025-06-02'),
    ?,
    ?
);

-- Test3: Order not found
-- Check how the procedure handles a non-existing order.
CALL "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."UPDATE_DELIVERY_STATUS"(
    99999,
    1,
    TO_DATE('2025-06-02'),
    ?,
    ?
);


-- Task3: Table Function - Reporting & Analytics
-- Test queries for TF_DELIVERY_PERFORMANCE

-- Full reporting period
-- Compare carrier performance for all available order years.
SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE"(
    TO_DATE('2022-01-01'),
    TO_DATE('2026-12-31')
)
ORDER BY ON_TIME_RATE DESC;


-- Single-year report
-- Compare carrier performance for orders placed in 2025.
SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE"(
    TO_DATE('2025-01-01'),
    TO_DATE('2025-12-31')
)
ORDER BY ON_TIME_RATE DESC;


-- Half-year report
-- Compare carrier performance for orders placed in the first half of 2026.
SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE"(
    TO_DATE('2026-01-01'),
    TO_DATE('2026-06-30')
)
ORDER BY ON_TIME_RATE DESC;


-- Advanced Table Function Test
-- Verify carrier ranking using the RANK() window function.
-- The ranking is calculated inside TF_DELIVERY_PERFORMANCE_ADVANCED.

SELECT *
FROM "APRZYGODA_HANA_FINAL_PROJECT_HDI_DB_1"."TF_DELIVERY_PERFORMANCE_ADVANCED"(
    TO_DATE('2022-01-01'),
    TO_DATE('2026-12-31')
)
ORDER BY CARRIER_RANK;