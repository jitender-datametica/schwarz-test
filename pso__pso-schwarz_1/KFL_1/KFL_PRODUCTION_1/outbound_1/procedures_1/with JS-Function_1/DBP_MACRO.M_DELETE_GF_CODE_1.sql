CREATE OR REPLACE PROCEDURE `dbp_macro.m_delete_gf_code`(
  gf_id FLOAT64,
  mandant_id FLOAT64
)
BEGIN
  DECLARE exists_count INT64;
  DECLARE table_name STRING;

  -- Start transaction
  BEGIN TRANSACTION;

  -- 1. Check if the record exists
  SET exists_count = (
    SELECT COUNT(1) 
    FROM `dbp_security.gf_code_1` 
    WHERE gf_id = gf_id AND mandant_id = mandant_id
  );

  IF exists_count = 0 THEN
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eingegebene gf_id für den eingegebenen mandant_id existiert nicht in der Zieltabelle !!!' AS result;
  ELSE
    -- 2. Capture the record to be deleted for control/audit
    -- In BigQuery, we can simply select the result or use a temp table.
    -- To mimic your logic, we create a temporary table.
    CREATE OR REPLACE TEMP TABLE deleted_gf_code_log AS
    SELECT
      'gelöschter gf_code_1 für folgende gf_id & mandant_id' AS status_1,
      gf_id,
      mandant_id
    FROM `dbp_security.gf_code_1`
    WHERE gf_id = gf_id AND mandant_id = mandant_id;

    -- 3. Perform the actual deletion
    DELETE FROM `dbp_security.gf_code_1`
    WHERE gf_id = gf_id AND mandant_id = mandant_id;

    COMMIT TRANSACTION;

    -- 4. Return the log contents (similar to returning the tablelist)
    SELECT * FROM deleted_gf_code_log;
  END IF;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;