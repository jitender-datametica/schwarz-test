CREATE OR REPLACE PROCEDURE `dbp_macro.m_lis_leist_einzelauswertung_wup`(
  aktion STRING,
  mandant_id FLOAT64,
  wup_id FLOAT64,
  leist_einzelauswertung_fg FLOAT64
)
BEGIN
  DECLARE mandant_exists BOOL;
  DECLARE wup_exists BOOL;
  DECLARE record_exists BOOL;
  DECLARE result_msg STRING;

  -- Start Transaction
  BEGIN TRANSACTION;

  -- 1. Validate Aktion
  IF aktion NOT IN ('INS', 'DELETE FROM', 'UPD') THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültige Aktion' AS result;
    RETURN;
  END IF;

  -- 2. Validate Flag (0 or 1)
  IF (leist_einzelauswertung_fg NOT IN (0, 1)) AND (aktion IN ('INS', 'UPD') OR (aktion = 'DELETE FROM' AND mandant_id IS NOT NULL AND wup_id IS NOT NULL)) THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültiges Flag leist_einzelauswertung_fg, zulässig 0 oder 1' AS result;
    RETURN;
  END IF;

  -- 3. Validate Mandant Range (-128 to 127)
  IF (mandant_id > 127 OR mandant_id < -128 OR mandant_id IS NULL) AND (aktion IN ('INS', 'UPD') OR (aktion = 'DELETE FROM' AND mandant_id IS NOT NULL AND wup_id IS NOT NULL)) THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültiger Mandant, zulässige Werte: mandant_id von -128 bis 127' AS result;
    RETURN;
  END IF;

  -- 4. Check if Mandant exists in database
  SET mandant_exists = (
    SELECT EXISTS(SELECT 1 FROM `dbp_data.mandant` WHERE mandant_id = CAST(mandant_id AS INT64))
  );
  
  IF NOT mandant_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'Der eingegebene Mandant existiert nicht' AS result;
    RETURN;
  END IF;

  -- 5. Check if Verteilzentrum (WUP) is valid
  SET wup_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_data.wup` 
      WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id
    )
  );

  IF NOT wup_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'Kein gültiges Verteilzentrum' AS result;
    RETURN;
  END IF;

  -- 6. Logic for INS: Check for existing record
  IF aktion = 'INS' THEN
    SET record_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_security.leist_einzelauswertung_wup`
        WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id
      )
    );
    IF record_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'Der Datensatz, den Sie einfügen möchten, existiert schon' AS result;
      RETURN;
    END IF;

    INSERT INTO `dbp_security.leist_einzelauswertung_wup` (mandant_id, wup_id, nb_id, leist_einzelauswertung_fg)
    VALUES (cast(mandant_id as int64), cast(wup_id as int64), -111, cast(leist_einzelauswertung_fg as int64));
  
  -- 7. Logic for DEL
  ELSEIF aktion = 'DELETE FROM' OR aktion = 'DEL' THEN
    DELETE FROM `dbp_security.leist_einzelauswertung_wup`
    WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id;

  -- 8. Logic for UPD
  ELSEIF aktion = 'UPD' THEN
    UPDATE `dbp_security.leist_einzelauswertung_wup`
    SET leist_einzelauswertung_fg = leist_einzelauswertung_fg
    WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id;
  END IF;

  -- 9. Generate result message
  SET result_msg = (
    SELECT CASE 
      WHEN aktion = 'INS' THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde hinzugefügt'
      WHEN aktion IN ('DELETE FROM', 'DEL') THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde gelöscht'
      WHEN aktion = 'UPD' AND leist_einzelauswertung_fg = 1 THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde für Einzelauswertung freigeschaltet'
      WHEN aktion = 'UPD' AND leist_einzelauswertung_fg = 0 THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde für Einzelauswertung gesperrt'
    END
  );

  -- Create Temp Table for output (mirrors Snowflake tablelist logic)
  CREATE OR REPLACE TEMP TABLE proc_result_log AS SELECT result_msg AS status;

  COMMIT TRANSACTION;

  -- Return result
  SELECT * FROM proc_result_log;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;