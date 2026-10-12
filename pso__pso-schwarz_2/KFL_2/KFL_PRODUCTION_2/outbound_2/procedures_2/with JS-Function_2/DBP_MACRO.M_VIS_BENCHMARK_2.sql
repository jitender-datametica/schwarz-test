CREATE OR REPLACE PROCEDURE `dbp_macro.m_vis_benchmark`(
  aktion_2 STRING,
  mandant_id FLOAT64,
  hierarchie_ebene_id STRING,
  hierarchie_element_id FLOAT64,
  user_id STRING,
  upd_hierarchie_ebene_id STRING,
  upd_hierarchie_element_id FLOAT64
)
BEGIN
  -- Variable Declarations for Validation
  DECLARE exists_check INT64;
  DECLARE retval STRING DEFAULT '';
  DECLARE cleaned_user_id STRING DEFAULT TRIM(user_id);

  -- Start Transaction
  BEGIN TRANSACTION;

  -- 1. ACTION VALIDATION
  IF aktion_2 NOT IN ('INS', 'DEL', 'UPD') THEN
    RAISE USING MESSAGE = 'Ungültige Aktion_2';
  END IF;

  -- 2. MANDANT_2 RANGE VALIDATION
  IF (mandant_id > 127 OR mandant_id < -128 OR mandant_id IS NULL) 
     AND (aktion_2 IN ('INS', 'UPD') OR (aktion_2 = 'DEL' AND mandant_id IS NOT NULL)) THEN
    RAISE USING MESSAGE = 'Ungültiger Mandant_2, zulässige Werte: mandant_id von -128 bis 127';
  END IF;

  -- 3. LAND_2 LEVEL VALIDATION
  IF hierarchie_ebene_id = 'land_2' AND (hierarchie_element_id > 127 OR hierarchie_element_id < -128) THEN
    RAISE USING MESSAGE = "Ungültiger Wert fuer das Element der Hierarchiestufe 'land_2', zulässige Werte: mandant_id von -128 bis 127";
  END IF;

  -- 4. MANDANT_2 EXISTENCE CHECK
  SET exists_check = (SELECT COUNT(1) FROM `dbp_data.mandant_2` WHERE mandant_id = CAST(mandant_id AS INT64));
  IF exists_check = 0 AND (aktion_2 IN ('INS', 'UPD') OR (aktion_2 = 'DEL' AND mandant_id IS NOT NULL)) THEN
    RAISE USING MESSAGE = 'Der eingegebene Mandant_2 existiert nicht';
  END IF;

  -- 5. HIERARCHY_2 LEVEL/ELEMENT CHECKS
  IF hierarchie_ebene_id = 'UNDEFINED' AND aktion_2 IN ('INS', 'UPD') THEN
    RAISE USING MESSAGE = 'Bitte geben Sie eine_2 Hierarchieebene an';
  END IF;

  IF (hierarchie_element_id IS NULL OR CAST(hierarchie_element_id AS STRING) = 'UNDEFINED') 
     AND (aktion_2 IN ('INS', 'UPD') OR (aktion_2 = 'DEL' AND hierarchie_element_id IS NOT NULL)) THEN
    RAISE USING MESSAGE = 'Bitte geben Sie ein Hierarchieelement an';
  END IF;

  IF hierarchie_ebene_id NOT IN ('land_2', 'gf_2', 'vs_2', 'vkl_2', 'hl_2', 'fm') 
     AND (aktion_2 IN ('INS', 'UPD') OR (aktion_2 = 'DEL' AND hierarchie_ebene_id IS NOT NULL)) THEN
    RAISE USING MESSAGE = 'Ungültige Hierarchieebene, zulässige Werte: land_2 (vorstand), gf_2, vs_2, vkl_2, hl_2, fm';
  END IF;

  -- 6. DYNAMIC VALIDATION BASED ON HIERARCHY_2 TYPE
  CASE hierarchie_ebene_id
    WHEN 'gf_2' THEN
      SET exists_check = (SELECT COUNT(1) FROM `dbp_msi_data.wup_denorm_2` WHERE mandant_id = mandant_id AND gf_gbl_vertrieb_id = hierarchie_element_id);
      IF exists_check = 0 THEN RAISE USING MESSAGE = 'GF_2 ID existiert für diesen Mandanten nicht'; END IF;
    WHEN 'vkl_2' THEN
      SET exists_check = (SELECT COUNT(1) FROM `dbp_msi_data.wup_denorm_2` WHERE mandant_id = mandant_id AND vkl_id = hierarchie_element_id);
      IF exists_check = 0 THEN RAISE USING MESSAGE = 'VKL_2 ID existiert für diesen Mandanten nicht'; END IF;
    WHEN 'hl_2' THEN
      SET exists_check = (SELECT COUNT(1) FROM `dbp_msi_data.wup_denorm_2` WHERE mandant_id = mandant_id AND hl_id = hierarchie_element_id);
      IF exists_check = 0 THEN RAISE USING MESSAGE = 'HL_2 ID existiert für diesen Mandanten nicht'; END IF;
    WHEN 'vs_2' THEN
      SET exists_check = (SELECT COUNT(1) FROM `dbp_data.vs_2` WHERE mandant_id = mandant_id AND vs_id = hierarchie_element_id);
      IF exists_check = 0 THEN RAISE USING MESSAGE = 'VS_2 ID existiert für diesen Mandanten nicht'; END IF;
    WHEN 'fm' THEN
      SET exists_check = (SELECT COUNT(1) FROM `dbp_msi_data.wup_denorm_2` WHERE mandant_id = mandant_id AND frische_manager_id = hierarchie_element_id);
      IF exists_check = 0 THEN RAISE USING MESSAGE = 'FM ID existiert für diesen Mandanten nicht'; END IF;
    WHEN 'land_2' THEN
      IF hierarchie_element_id NOT IN (-1, -2) THEN
        SET exists_check = (SELECT COUNT(1) FROM `dbp_data.mandant_2` WHERE mandant_id = hierarchie_element_id);
        IF exists_check = 0 THEN RAISE USING MESSAGE = 'Kein zulässiger Wert für die Hierarchiestufe Land_2 (Vorstand)'; END IF;
      END IF;
  END CASE;

  -- 7. USER_ID CHECK
  IF user_id IS NULL THEN
    RAISE USING MESSAGE = 'Bitte geben Sie einen MSI User an';
  END IF;

  -- 8. UPDATE PRE-EXISTENCE CHECKS
  IF aktion_2 = 'UPD' THEN
    SET exists_check = (SELECT COUNT(1) FROM `dbp_msi_data.user_vis_benchmark_zu_2` 
                        WHERE mandant_id = mandant_id AND hierarchie_ebene_id = upd_hierarchie_ebene_id 
                        AND hierarchie_element_id = upd_hierarchie_element_id AND user_id = cleaned_user_id);
    IF exists_check = 0 THEN RAISE USING MESSAGE = 'Der Datensatz, den Sie aktualisieren möchten, existiert nicht'; END IF;
  END IF;

  -- 9. DML OPERATIONS VIA EXECUTE IMMEDIATE
  
  -- INS Logic

  EXECUTE IMMEDIATE """
    INSERT INTO `dbp_msi_data.user_vis_benchmark_zu_2` (
      mandant_id, 
      hierarchie_element_id, 
      hierarchie_ebene_id, 
      user_id
    ) 
    SELECT 
      COALESCE(cast(? as int64), 0), 
      COALESCE(cast(? as int64), 0), 
      COALESCE(?, ''), 
      ?
    FROM (SELECT CURRENT_DATE("Europe/Berlin") AS dat_akt) d
    WHERE ? = 'INS'
  """
  USING 
    mandant_id, 
    hierarchie_element_id, 
    hierarchie_ebene_id, 
    cleaned_user_id, 
    aktion_2;

  -- DEL Logic (Multiple scenarios)
  EXECUTE IMMEDIATE """
    DELETE FROM `dbp_msi_data.user_vis_benchmark_zu_2`
    WHERE user_id = ? AND ? = 'DEL'
    AND (? IS NULL OR mandant_id = ?)
    AND (? IS NULL OR hierarchie_ebene_id = ?)
    AND (? IS NULL OR hierarchie_element_id = ?)
  """ USING cleaned_user_id, aktion_2, mandant_id, mandant_id, hierarchie_ebene_id, hierarchie_ebene_id, hierarchie_element_id, hierarchie_element_id;

  -- UPD Logic
  EXECUTE IMMEDIATE """
    UPDATE `dbp_msi_data.user_vis_benchmark_zu_2`
    SET hierarchie_element_id = COALESCE(cast(? as int64), 0),
        hierarchie_ebene_id = COALESCE(?, '')
    WHERE mandant_id = ? AND user_id = ?
    AND hierarchie_ebene_id = ? AND hierarchie_element_id = ?
    AND ? = 'UPD'
  """ USING hierarchie_element_id, hierarchie_ebene_id, mandant_id, cleaned_user_id, upd_hierarchie_ebene_id, upd_hierarchie_element_id, aktion_2;

  -- 10. CONSTRUCT RETURN MESSAGE
  IF aktion_2 = 'INS' THEN
    SET retval = FORMAT('Der Benutzer %s wurde der Hierarchiestufe %s, Element %t erfolgreich zugeordnet.', cleaned_user_id, hierarchie_ebene_id, hierarchie_element_id);
  ELSEIF aktion_2 = 'DEL' THEN
    IF hierarchie_ebene_id IS NULL AND hierarchie_element_id IS NULL AND mandant_id IS NULL THEN
      SET retval = FORMAT("Es wurden alle Zuordnungen für den Benutzer '%s' gelöscht.", cleaned_user_id);
    ELSEIF mandant_id IS NOT NULL AND hierarchie_ebene_id IS NULL THEN
      SET retval = FORMAT("Es wurden alle Zuordnungen für den Benutzer '%s' und den Mandanten '%t' gelöscht.", cleaned_user_id, mandant_id);
    ELSEIF hierarchie_ebene_id IS NOT NULL AND hierarchie_element_id IS NULL THEN
      SET retval = FORMAT("Es wurden alle Zuordnungen für den Benutzer '%s' und den Mandanten '%t' der Hierarchiestufe '%s' gelöscht.", cleaned_user_id, mandant_id, hierarchie_ebene_id);
    ELSE
      SET retval = FORMAT("Die Zuordnung des Benutzers '%s' zur Hierarchiestufe '%s', Element '%t' wurde gelöscht.", cleaned_user_id, hierarchie_ebene_id, upd_hierarchie_element_id);
    END IF;
  ELSE -- UPD
    SET retval = FORMAT("Die Zuordnung Benutzer '%s', Hierarchiestufe '%s', Element '%t' wurde auf Hierarchiestufe '%s', Element '%t' aktualisiert.", 
                 cleaned_user_id, upd_hierarchie_ebene_id, upd_hierarchie_element_id, hierarchie_ebene_id, hierarchie_element_id);
  END IF;

  COMMIT TRANSACTION;
  SELECT retval AS result;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;