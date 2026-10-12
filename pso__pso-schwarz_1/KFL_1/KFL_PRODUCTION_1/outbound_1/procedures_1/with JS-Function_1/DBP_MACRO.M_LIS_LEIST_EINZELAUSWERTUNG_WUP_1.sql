CREATE OR REPLACE PROCEDURE `dbp_macro.m_lis_leist_einzelauswertung_wup`(
  aktion_1 STRING,
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

  -- 1. Validate Aktion_1
  IF aktion_1 NOT IN ('INS', 'DELETE FROM', 'UPD') THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültige Aktion_1' AS result;
    RETURN;
  END IF;

  -- 2. Validate Flag (0 or 1)
  IF (leist_einzelauswertung_fg NOT IN (0, 1)) AND (aktion_1 IN ('INS', 'UPD') OR (aktion_1 = 'DELETE FROM' AND mandant_id IS NOT NULL AND wup_id IS NOT NULL)) THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültiges Flag leist_einzelauswertung_fg, zulässig 0 oder 1' AS result;
    RETURN;
  END IF;

  -- 3. Validate Mandant_1 Range (-128 to 127)
  IF (mandant_id > 127 OR mandant_id < -128 OR mandant_id IS NULL) AND (aktion_1 IN ('INS', 'UPD') OR (aktion_1 = 'DELETE FROM' AND mandant_id IS NOT NULL AND wup_id IS NOT NULL)) THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültiger Mandant_1, zulässige Werte: mandant_id von -128 bis 127' AS result;
    RETURN;
  END IF;

  -- 4. Check if Mandant_1 exists in database
  SET mandant_exists = (
    SELECT EXISTS(SELECT 1 FROM `dbp_data.mandant_1` WHERE mandant_id = CAST(mandant_id AS INT64))
  );
  
  IF NOT mandant_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'Der eingegebene Mandant_1 existiert nicht' AS result;
    RETURN;
  END IF;

  -- 5. Check if Verteilzentrum (WUP_1) is valid
  SET wup_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_data.wup_1` 
      WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id
    )
  );

  IF NOT wup_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'Kein gültiges Verteilzentrum' AS result;
    RETURN;
  END IF;

  -- 6. Logic for INS: Check for existing record
  IF aktion_1 = 'INS' THEN
    SET record_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_security.leist_einzelauswertung_wup_1`
        WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id
      )
    );
    IF record_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'Der Datensatz, den Sie einfügen möchten, existiert schon' AS result;
      RETURN;
    END IF;

    INSERT INTO `dbp_security.leist_einzelauswertung_wup_1` (mandant_id, wup_id, nb_id, leist_einzelauswertung_fg)
    VALUES (cast(mandant_id as int64), cast(wup_id as int64), -111, cast(leist_einzelauswertung_fg as int64));
  
  -- 7. Logic for DEL
  ELSEIF aktion_1 = 'DELETE FROM' OR aktion_1 = 'DEL' THEN
    DELETE FROM `dbp_security.leist_einzelauswertung_wup_1`
    WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id;

  -- 8. Logic for UPD
  ELSEIF aktion_1 = 'UPD' THEN
    UPDATE `dbp_security.leist_einzelauswertung_wup_1`
    SET leist_einzelauswertung_fg = leist_einzelauswertung_fg
    WHERE mandant_id = mandant_id AND nb_id = -111 AND wup_id = wup_id;
  END IF;

  -- 9. Generate result message
  SET result_msg = (
    SELECT CASE 
      WHEN aktion_1 = 'INS' THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde hinzugefügt'
      WHEN aktion_1 IN ('DELETE FROM', 'DEL') THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde gelöscht'
      WHEN aktion_1 = 'UPD' AND leist_einzelauswertung_fg = 1 THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde für Einzelauswertung freigeschaltet'
      WHEN aktion_1 = 'UPD' AND leist_einzelauswertung_fg = 0 THEN 'Das VZ '||TRIM(CAST(wup_id AS STRING))||' wurde für Einzelauswertung gesperrt'
    END
  );

  -- Create Temp Table for output (mirrors Snowflake tablelist logic)
  CREATE OR REPLACE TEMP TABLE proc_result_log AS SELECT result_msg AS status_1;

  COMMIT TRANSACTION;

  -- Return result
  SELECT * FROM proc_result_log;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;