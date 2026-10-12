CREATE OR REPLACE PROCEDURE `dbp_macro.sp_nettostunden_sonstige_temp`(
  in_mandant_id FLOAT64,
  in_nb_id FLOAT64,
  in_wup_id FLOAT64,
  in_dat STRING,
  in_stunden_ist_kasse FLOAT64,
  in_stunden_ist_frische FLOAT64,
  in_stunden_ist_ware FLOAT64,
  in_stunden_ist_verwaltung FLOAT64
)
BEGIN
  -- Variable Declarations
  DECLARE var_wrg_id STRING;
  DECLARE var_dat_zeit_aenderung DATETIME DEFAULT CURRENT_DATETIME();
  DECLARE var_total_stunden FLOAT64 DEFAULT 0.0;
  DECLARE var_quelle_id INT64 DEFAULT 9;
  DECLARE var_stunden_typ_fg INT64 DEFAULT 0;
  DECLARE sql_stmt STRING;
  DECLARE is_abs_mandant BOOL;
  DECLARE current_hrs FLOAT64;

  -- 1. Determine Currency (WRG_ID)
  SET var_wrg_id = CASE in_mandant_id
    WHEN 2 THEN 'CZK'
    WHEN 3 THEN 'PLN'
    WHEN 4 THEN 'MDL'
    WHEN 6 THEN 'HRK'
    WHEN 7 THEN 'RON'
    WHEN 8 THEN 'BGN'
    ELSE 'EUR'
  END;

  -- 2. Check if Mandant_2 requires Absolute Values (2, 5, 8)
  SET is_abs_mandant = in_mandant_id IN (2, 5, 8);

  -- Start Transaction
  BEGIN TRANSACTION;

  -- 3. Perform Departmental Merges (Looping through the 4 areas)
  FOR dept IN (
    SELECT 10 AS area_id, in_stunden_ist_kasse AS hrs UNION ALL
    SELECT 30 AS area_id, in_stunden_ist_frische AS hrs UNION ALL
    SELECT 40 AS area_id, in_stunden_ist_ware AS hrs UNION ALL
    SELECT 60 AS area_id, in_stunden_ist_verwaltung AS hrs
  )
  DO
    
    
    -- Apply Absolute Value logic if Mandant_2 is 2, 5, or 8
    SET current_hrs = IF(is_abs_mandant, ABS(COALESCE(dept.hrs, 0.0)), COALESCE(dept.hrs, 0.0));
    SET var_total_stunden = var_total_stunden + current_hrs;

    SET sql_stmt = """
      MERGE INTO `dbp_data.nettostunden_bereich_2` AS tgt
      USING (SELECT CAST(? AS INT64) as wup_id, CAST(? AS INT64) as nb_id, CAST(? AS INT64) as mandant_id, CAST(? AS DATE) as dat, ? as quelle_id, ? as area_id) AS src
      ON  tgt.wup_id = src.wup_id AND tgt.nb_id = src.nb_id AND tgt.mandant_id = src.mandant_id 
      AND tgt.dat = src.dat AND tgt.quelle_id = src.quelle_id AND tgt.hr_objekt_bereich_id = src.area_id
      WHEN MATCHED THEN
        UPDATE SET dat_zeit_aenderung = ?, stunden_2 = CAST(? AS NUMERIC)
      WHEN NOT MATCHED THEN
        INSERT (mandant_id, wup_id, nb_id, dat, hr_objekt_bereich_id, stunden_2, quelle_id, stunden_typ_fg, dat_zeit_aenderung)
        VALUES (CAST(? AS INT64), CAST(? AS INT64), CAST(? AS INT64), ?, ?, CAST(? AS NUMERIC), ?, ?, ?)
    """;

    EXECUTE IMMEDIATE sql_stmt USING 
      in_wup_id, in_nb_id, in_mandant_id, in_dat, var_quelle_id, dept.area_id,
      var_dat_zeit_aenderung, current_hrs,
      in_mandant_id, in_wup_id, in_nb_id, CAST(in_dat AS DATE), dept.area_id, current_hrs, var_quelle_id, var_stunden_typ_fg, var_dat_zeit_aenderung;
  END FOR;

  -- 4. Final Merge into wup_stunden_tag_2 (Using EXECUTE IMMEDIATE)
  SET sql_stmt = """
    MERGE INTO `dbp_data.wup_stunden_tag_2` AS tgt
    USING (SELECT CAST(? AS INT64) as wup_id, CAST(? AS INT64) as nb_id, CAST(? AS INT64) as mandant_id, CAST(? AS DATE) as dat) AS src
    ON  tgt.wup_id = src.wup_id AND tgt.nb_id = src.nb_id AND tgt.mandant_id = src.mandant_id AND tgt.dat = src.dat
    WHEN MATCHED THEN
      UPDATE SET stunden_sonstige = CAST(? AS NUMERIC)  
    WHEN NOT MATCHED THEN
      INSERT (
        wup_id, nb_id, mandant_id, dat, stunden_markt, stunden_sonstige, 
        stunden_plan, stunden_co5_sonstige, ums_netto_plan, ums_netto_plan_man, wrg_id
      )
      VALUES (CAST(? AS INT64), CAST(? AS INT64), CAST(? AS INT64), ?, 0, CAST(? AS NUMERIC), NULL, 0, 0, NULL, ?)
  """;

  EXECUTE IMMEDIATE sql_stmt USING 
    in_wup_id, in_nb_id, in_mandant_id, in_dat,
    var_total_stunden,
    in_wup_id, in_nb_id, in_mandant_id, CAST(in_dat AS DATE), var_total_stunden, var_wrg_id;

  COMMIT TRANSACTION;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;