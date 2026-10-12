CREATE OR REPLACE PROCEDURE `dbp_macro.m_lis_leist_empfaenger_ldap_zu`(
  mandant_id FLOAT64,
  wup_id FLOAT64,
  ma_ldap STRING,
  leist_auswerteberechtigt_fg FLOAT64
)
BEGIN
  DECLARE mandant_exists BOOL;
  DECLARE wup_exists BOOL;
  DECLARE user_exists BOOL;
  DECLARE return_msg STRING;

  -- Start Transaction
  BEGIN TRANSACTION;
  
  -- 1. Validation: Flag range (0 or 1)
  IF (leist_auswerteberechtigt_fg != 0 AND leist_auswerteberechtigt_fg != 1) 
     AND mandant_id IS NOT NULL AND wup_id IS NOT NULL THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültiges Flag leist_auswerteberechtigt_fg, zulässig 0 oder 1' AS result;
    RETURN;
  END IF;

  -- 2. Validation: Mandant_2 ID range (-128 to 127)
  IF (mandant_id > 127 OR mandant_id < -128 OR mandant_id IS NULL) 
     AND mandant_id IS NOT NULL AND wup_id IS NOT NULL THEN
    ROLLBACK TRANSACTION;
    SELECT 'Ungültiger Mandant_2, zulässige Werte: mandant_id von -128 bis 127' AS result;
    RETURN;
  END IF;

  -- 3. Validation: Check if Mandant_2 exists
  IF mandant_id IS NOT NULL AND wup_id IS NOT NULL THEN
    SET mandant_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_data.mandant_2` 
        WHERE mandant_id = CAST(mandant_id AS INT64)
      )
    );

    IF NOT mandant_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'Der eingegebene Mandant_2 existiert nicht' AS result;
      RETURN;
    END IF;
  END IF;

  -- 4. Validation: Check if Verteilzentrum (WUP_2) exists
  IF mandant_id IS NOT NULL AND wup_id IS NOT NULL THEN
    SET wup_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_data.wup_2`
        WHERE mandant_id = mandant_id
          AND nb_id = -111
          AND wup_id = wup_id
      )
    );

    IF NOT wup_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'Kein gültiges Verteilzentrum' AS result;
      RETURN;
    END IF;
  END IF;

  -- 5. Validation: Check if VZ / LDAP User combination exists
  IF mandant_id IS NOT NULL AND wup_id IS NOT NULL THEN
    SET user_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_security.leist_empfaenger_ldap_zu_2`
        WHERE ma_ldap = ma_ldap
          AND mandant_id = mandant_id
          AND wup_id = wup_id
          AND nb_id = -111
      )
    );

    IF NOT user_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'Keine gültige VZ / LDAP User Kombination' AS result;
      RETURN;
    END IF;
  END IF;

  -- 6. Perform the Update
  UPDATE `dbp_security.leist_empfaenger_ldap_zu_2`
  SET leist_auswerteberechtigt_fg = leist_auswerteberechtigt_fg
  WHERE mandant_id = mandant_id
    AND nb_id = -111
    AND wup_id = wup_id
    AND ma_ldap = ma_ldap;

  -- 7. Prepare the Return Message
  SET return_msg = (
    SELECT CASE 
      WHEN leist_auswerteberechtigt_fg = 1 THEN 'Der User '||TRIM(ma_ldap)||' wurde für Einzelauswertung freigeschaltet'
      WHEN leist_auswerteberechtigt_fg = 0 THEN 'Der User '||TRIM(ma_ldap)||' wurde für Einzelauswertung gesperrt'
    END
  );

  COMMIT TRANSACTION;
  
  -- Final Output
  SELECT return_msg AS result;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;