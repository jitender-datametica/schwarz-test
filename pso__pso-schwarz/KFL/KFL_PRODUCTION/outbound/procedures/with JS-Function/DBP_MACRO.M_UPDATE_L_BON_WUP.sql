CREATE OR REPLACE PROCEDURE `dbp_macro.m_update_l_bon_wup`(
  mandant_id FLOAT64,
  wup_id FLOAT64
)
BEGIN
  DECLARE mandant_exists BOOL;
  DECLARE wup_exists BOOL;

  -- Start Transaction
  BEGIN TRANSACTION;

  -- 1. Check if mandant_id exists
  SET mandant_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_view.v_mandant` 
      WHERE mandant_id = mandant_id
    )
  );

  IF NOT mandant_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eingegebene mandant_id existiert nicht !!!' AS result;
  ELSE
    -- 2. Check if wup_id exists
    SET wup_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_view.v_wup` 
        WHERE wup_id = wup_id
      )
    );

    IF NOT wup_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'ACHTUNG: eingegebene wup_id existiert nicht in der Tabelle wup !!!' AS result;
    ELSE
      -- 3. Capture "BEFORE" state in a temp table
      CREATE OR REPLACE TEMP TABLE audit_log AS
      SELECT
        'VORHER' AS status,
        v01.*
      FROM `dbp_msi_v_view.v_l_bon_wup` AS v01
      WHERE v01.mandant_id = mandant_id AND v01.wup_id = wup_id;

      -- 4. Update the record
      UPDATE `dbp_msi_data.l_bon_wup`
      SET
        bda_anym_fg = 0,
        gesperrt_fg = 0,
        dat = CURRENT_DATE("Europe/Berlin"),
        user_id = SESSION_USER() -- Matches Snowflake's USER
      WHERE mandant_id = mandant_id AND wup_id = wup_id;

      -- 5. Capture "AFTER" state and append to temp table
      INSERT INTO audit_log
      SELECT
        'NACHHER' AS status,
        v01.*
      FROM `dbp_msi_v_view.v_l_bon_wup` AS v01
      WHERE v01.mandant_id = mandant_id AND v01.wup_id = wup_id;

      COMMIT TRANSACTION;

      -- Return the audit log (replaces returning table names)
      SELECT * FROM audit_log ORDER BY status DESC; -- VORHER then NACHHER
    END IF;
  END IF;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;