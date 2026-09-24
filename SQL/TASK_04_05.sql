-- Test 1: View all combined data
SELECT * FROM "CAC_I_ORDERS_UNION" LIMIT 20;

-- Test 2: Check data from each source
SELECT DATA_SOURCE, 
COUNT(*) AS ROW_COUNT, 
SUM(AMOUNT) AS TOTAL
FROM "CAC_I_ORDERS_UNION"
GROUP BY DATA_SOURCE;

-- Test 3: Test pruning (if enabled) - should only query one source
SELECT *
FROM "CAC_I_ORDERS_UNION"
WHERE DATA_SOURCE = 'Active'
LIMIT 10;