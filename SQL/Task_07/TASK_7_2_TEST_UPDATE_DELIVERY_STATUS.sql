-- Stored Procedure: UPDATE_DELIVERY_STATUS - test cases

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