CREATE OR REPLACE PROCEDURE `dbp_macro.m_insert_user_hr_objekt_id_zu`(
  mandant_id FLOAT64,
  hr_objekt_ebene1_id FLOAT64,
  user_id STRING
)
BEGIN
  DECLARE mandant_exists BOOL;
  DECLARE hierarchy_exists BOOL;
  DECLARE duplicate_exists BOOL;

  -- Start Transaction
  BEGIN TRANSACTION;

  -- 1. Check if mandant_2 exists
  SET mandant_exists = (
    SELECT EXISTS(
      SELECT 1 FROM `dbp_view.v_mandant_2` 
      WHERE mandant_id = mandant_id
    )
  );

  IF NOT mandant_exists THEN
    ROLLBACK TRANSACTION;
    SELECT 'Mandant_2 existiert nicht' AS result;
  ELSE
    -- 2. Check if hr_objekt_ebene1_id exists for that mandant_2
    SET hierarchy_exists = (
      SELECT EXISTS(
        SELECT 1 FROM `dbp_view.v_org_einheit_hierarchie_2` 
        WHERE mandant_id = mandant_id 
          AND hr_objekt_ebene1_id = hr_objekt_ebene1_id
      )
    );

    IF NOT hierarchy_exists THEN
      ROLLBACK TRANSACTION;
      SELECT 'Einstiegsebene (hr_objekt_id) existiert nicht' AS result;
    ELSE
      -- 3. Check for duplicates in the target table
      SET duplicate_exists = (
        SELECT EXISTS(
          SELECT 1 FROM `dbp_security.user_hr_objekt_id_zu_2`
          WHERE user_id = user_id 
            AND mandant_id = mandant_id 
            AND hr_objekt_ebene1_id = hr_objekt_ebene1_id
        )
      );

      IF duplicate_exists THEN
        ROLLBACK TRANSACTION;
        SELECT 'DB-User mit der eingegebenen Einstiegsebene ist bereits in der Zieltabelle vorhanden' AS result;
      ELSE
        -- 4. Insert the new record
        INSERT INTO `dbp_security.user_hr_objekt_id_zu_2` (
          mandant_id, 
          hr_objekt_ebene1_id, 
          user_id
        )
        VALUES (cast(mandant_id as int64), cast(hr_objekt_ebene1_id as int64), user_id);

        -- 5. Create a temporary log table for confirmation (replaces Snowflake session-id table)
        CREATE OR REPLACE TEMP TABLE insert_confirmation_log AS
        SELECT
          'neuer User' AS status_2,
          user_id,
          mandant_id,
          hr_objekt_ebene1_id
        FROM `dbp_security.user_hr_objekt_id_zu_2`
        WHERE user_id = user_id
          AND mandant_id = mandant_id
          AND hr_objekt_ebene1_id = hr_objekt_ebene1_id;

        COMMIT TRANSACTION;

        -- Return the confirmation record
        SELECT * FROM insert_confirmation_log;
      END IF;
    END IF;
  END IF;

EXCEPTION WHEN ERROR THEN
  -- Catch-all for system errors
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;