-- Task_08


-- Phase 1

-- Check if roles were created
SELECT ROLE_NAME, ROLE_SCHEMA_NAME
FROM ROLES
WHERE ROLE_NAME LIKE '%analyst_role%'
   OR ROLE_NAME LIKE '%developer_role%'
   OR ROLE_NAME LIKE '%app_service_role%'
ORDER BY ROLE_NAME;



-- Phase 2

-- Verify the granted roles by grantee
SELECT GRANTEE, ROLE_NAME, IS_GRANTABLE
FROM GRANTED_ROLES
WHERE GRANTEE = 'P080475';


-- Verify the granted privileges by grantee
SELECT GRANTEE, PRIVILEGE
FROM GRANTED_PRIVILEGES
WHERE GRANTEE = 'P080475';


-- Check privileges assigned to roles with these names
-- Results may include roles from other HDI schemas
SELECT GRANTEE AS ROLE_NAME, PRIVILEGE, OBJECT_NAME
FROM GRANTED_PRIVILEGES
WHERE GRANTEE IN (
    'analyst_role',
    'developer_role',
    'app_service_role'
)
ORDER BY GRANTEE, PRIVILEGE;



-- Phase 3

-- Test Read Access
-- Test 1: Query partner's calculation view
SELECT *
FROM "AGNIESZKASFINALPROJECT_HDI_DB_1"."CV_SALES_ANALYSIS"
LIMIT 10;

-- Test 2: Count records
SELECT COUNT(*) AS TOTAL_RECORDS
FROM "AGNIESZKASFINALPROJECT_HDI_DB_1"."CV_SALES_ANALYSIS";


-- Verify Row-Level Security (Analytic Privilege)
-- Test 3: Query the secured view and check what data you can see
SELECT
    REGION,
    COUNT(*) AS ROW_COUNT,
    SUM(AMOUNT) AS TOTAL_AMOUNT
FROM "AGNIESZKASFINALPROJECT_HDI_DB_1"."CV_SALES_ANALYSIS"
GROUP BY REGION
ORDER BY REGION;

-- If privilege filters for EMEA region, you should only see EMEA data
-- Try to see all regions (this should still only show filtered data)
-- Test 4: Distinct regions - try to see all regions
SELECT DISTINCT REGION
FROM "AGNIESZKASFINALPROJECT_HDI_DB_1"."CV_SALES_ANALYSIS"
ORDER BY REGION;