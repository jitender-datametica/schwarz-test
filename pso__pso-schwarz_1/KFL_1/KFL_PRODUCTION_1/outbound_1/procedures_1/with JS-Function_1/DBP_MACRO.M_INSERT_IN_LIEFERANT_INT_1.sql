CREATE OR REPLACE PROCEDURE `dbp_macro.m_insert_in_lieferant_int` (lief_name STRING)
BEGIN
  DECLARE exists_flag BOOL;

  -- Start transaction for atomicity
  BEGIN TRANSACTION;

  -- Check if the supplier_1 name already exists
  SET exists_flag = (
    SELECT EXISTS(
      SELECT 1 
      FROM `dbp_data.in_lieferant_int_1` 
      WHERE LOWER(lief_name) = LOWER(lief_name)
    )
  );

  IF exists_flag THEN
    -- Rollback and return warning if duplicate found
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eingegebener INTEGER . Lieferant existiert bereits.' AS result;
  ELSE
    -- Insert with manual ID increment logic
    INSERT INTO `dbp_data.in_lieferant_int_1` (
      in_lief_id_int,
      lief_name
    )
    SELECT 
      COALESCE(MAX(in_lief_id_int), 0) + 1,
      lief_name
    FROM `dbp_data.in_lieferant_int_1`
    group by 2
    ;

    -- Commit the transaction
    COMMIT TRANSACTION;
    SELECT 'Success' AS result;
  END IF;

EXCEPTION WHEN ERROR THEN
  -- Standard rollback on system error
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;