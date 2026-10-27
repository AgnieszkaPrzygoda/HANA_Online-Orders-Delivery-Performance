DO
BEGIN
    -- Declare variables
    DECLARE v_order_id INTEGER DEFAULT 29;
    DECLARE v_line_item_id INTEGER DEFAULT 1;
    DECLARE v_delivery_date DATE DEFAULT TO_DATE('2025-06-02');
    DECLARE v_current_status NVARCHAR(50);
    DECLARE v_new_status NVARCHAR(50);
    DECLARE v_rows_updated INTEGER DEFAULT 0;

    -- Get current order status
    SELECT DELIVERY_STATUS INTO v_current_status
    FROM FACT_ORDERS
    WHERE ORDER_ID = :v_order_id
      AND LINE_ITEM_ID = :v_line_item_id;

	-- Determine new status
IF :v_current_status = 'Shipped'
   AND :v_delivery_date IS NOT NULL THEN
    v_new_status = 'Delivered';
ELSEIF :v_current_status = 'Shipped' THEN
    v_new_status = 'Shipped';
ELSE
    v_new_status = :v_current_status;
END IF;

     -- Update order
UPDATE FACT_ORDERS
SET DELIVERY_STATUS = :v_new_status,
    DELIVERY_DATE = :v_delivery_date
WHERE ORDER_ID = :v_order_id
  AND LINE_ITEM_ID = :v_line_item_id
  AND DELIVERY_STATUS = 'Shipped'
  AND :v_delivery_date IS NOT NULL;
  
    -- Get number of rows updated
   v_rows_updated = ::ROWCOUNT;

    -- Display result
    SELECT
        :v_order_id AS ORDER_ID,
        :v_line_item_id AS LINE_ITEM_ID,
        :v_current_status AS OLD_STATUS,
        :v_new_status AS NEW_STATUS,
        :v_rows_updated AS ROWS_UPDATED
    FROM DUMMY;
END;