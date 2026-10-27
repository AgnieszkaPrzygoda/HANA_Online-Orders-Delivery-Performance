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