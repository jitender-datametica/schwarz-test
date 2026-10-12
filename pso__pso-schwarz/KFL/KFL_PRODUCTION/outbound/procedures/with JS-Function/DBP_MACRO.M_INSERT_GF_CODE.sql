CREATE OR REPLACE PROCEDURE `dbp_macro.m_insert_gf_code`(
  gf_id FLOAT64,
  mandant_id FLOAT64,
  gf_code STRING
)
BEGIN
  DECLARE mandant_exists BOOL;
  DECLARE gf_exists BOOL;
  DECLARE duplicate_exists BOOL;

  -- Start transaction
  BEGIN TRANSACTION;

  -- 1. Check if mandant exists
  SET mandant_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_view.v_mandant` 
      WHERE mandant_id = mandant_id
    )
  );

  IF NOT mandant_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eigegebene mandant_id existiert nicht !!!' AS result;
    RETURN;
  END IF;

  -- 2. Check if gf_id exists for that mandant in lookup view
  SET gf_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_view.v_gf` 
      WHERE mandant_id = mandant_id 
        AND gf_id = gf_id
    )
  );

  IF NOT gf_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eingegebene gf_id existiert nicht für den eingegebenen mandant_id in der der Lookuptabelle dbx_data.gf !!!' AS result;
    RETURN;
  END IF;

  -- 3. Check if record already exists in security table
  SET duplicate_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_security.gf_code`
      WHERE gf_id = gf_id 
        AND mandant_id = mandant_id
    )
  );

  IF duplicate_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eingegebene gf_id für den eingegebenen mandant_id ist bereits in der Zieltabelle vorhanden !!!' AS result;
    RETURN;
  END IF;

  -- 4. Perform the Insert
  INSERT INTO `dbp_security.gf_code` (
    gf_id, 
    mandant_id, 
    gf_code
  )
  VALUES (cast(gf_id as int64), cast(mandant_id as int64), gf_code);

  -- 5. Commit changes
  COMMIT TRANSACTION;

  -- Return success message
  SELECT 'Success: neuer gf_code für folgenden gf_id & mandant_id generiert' AS result;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;