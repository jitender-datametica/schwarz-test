CREATE OR REPLACE PROCEDURE `dbp_macro.sp_nettostunden_sonstige`(
  mandant_id FLOAT64,
  nb_id FLOAT64,
  wup_id FLOAT64,
  dat DATE,
  stunden_ist_kasse FLOAT64,
  stunden_ist_frische FLOAT64,
  stunden_ist_ware FLOAT64,
  stunden_ist_verwaltung FLOAT64
)
BEGIN
  -- Variable Declarations
  DECLARE var_quelle_id INT64 DEFAULT 9;
  DECLARE var_stunden_typ_fg INT64 DEFAULT 0;
  DECLARE var_wrg_id STRING;
  DECLARE var_dat_zeit_aenderung DATETIME;
  DECLARE mandant_krz STRING;
  DECLARE var_total_stunden FLOAT64;
  DECLARE dynamic_sql STRING;

  -- 1. Determine Currency (WRG_ID)
  SET var_wrg_id = CASE mandant_id
    WHEN 2 THEN 'CZK'
    WHEN 3 THEN 'PLN'
    WHEN 4 THEN 'MDL'
    WHEN 6 THEN 'HRK'
    WHEN 7 THEN 'RON'
    WHEN 8 THEN 'BGN'
    ELSE 'EUR'
  END;

  -- 2. Set Change Timestamp
  SET var_dat_zeit_aenderung = CURRENT_DATETIME();

  -- 3. Determine Country_2 Suffix (Krz)
  SET mandant_krz = CASE mandant_id
    WHEN 1 THEN 'de'
    WHEN 2 THEN 'cz'
    WHEN 3 THEN 'pl'
    WHEN 4 THEN 'md'
    WHEN 5 THEN 'sk'
    WHEN 6 THEN 'hr'
    WHEN 7 THEN 'ro'
    WHEN 8 THEN 'bg'
    ELSE 'xx' -- Default/Error fallback
  END;

  -- 4. Calculate Total Hours
  SET var_total_stunden = COALESCE(stunden_ist_kasse, 0.0) + 
                          COALESCE(stunden_ist_frische, 0.0) + 
                          COALESCE(stunden_ist_ware, 0.0) + 
                          COALESCE(stunden_ist_verwaltung, 0.0);

  -- Start Transaction
  BEGIN TRANSACTION;

  -- 5. Perform Departmental Merges (Looping via a local array for efficiency)
  FOR dept IN (
    SELECT 10 AS area_id, COALESCE(stunden_ist_kasse, 0.0) AS hrs UNION ALL
    SELECT 30 AS area_id, COALESCE(stunden_ist_frische, 0.0) AS hrs UNION ALL
    SELECT 40 AS area_id, COALESCE(stunden_ist_ware, 0.0) AS hrs UNION ALL
    SELECT 60 AS area_id, COALESCE(stunden_ist_verwaltung, 0.0) AS hrs
  )
  DO
    SET dynamic_sql = """
      MERGE INTO `dbp_data.nettostunden_bereich_2` AS tgt
      USING (SELECT CAST(? AS INT64) as wup_id, CAST(? AS INT64) as nb_id, CAST(? AS NUMERIC) as mandant_id, ? as dat, ? as quelle_id, ? as area_id) AS src
      ON  tgt.wup_id = src.wup_id AND tgt.nb_id = src.nb_id AND tgt.mandant_id = src.mandant_id 
      AND tgt.dat = src.dat AND tgt.quelle_id = src.quelle_id AND tgt.hr_objekt_bereich_id = src.area_id
      WHEN MATCHED THEN
        UPDATE SET dat_zeit_aenderung = ?, stunden_2 = CAST(? AS NUMERIC)
      WHEN NOT MATCHED THEN
        INSERT (mandant_id, wup_id, nb_id, dat, hr_objekt_bereich_id, stunden_2, quelle_id, stunden_typ_fg, dat_zeit_aenderung)
        VALUES (CAST(? AS INT64),  CAST(? AS INT64), CAST(? AS INT64) , ?, ?, CAST(? AS NUMERIC), ?, ?, ?)
    """;

    EXECUTE IMMEDIATE dynamic_sql USING 
      wup_id, nb_id, mandant_id, dat, var_quelle_id, dept.area_id,
      var_dat_zeit_aenderung, dept.hrs,
      mandant_id, wup_id, nb_id, dat, dept.area_id, dept.hrs, var_quelle_id, var_stunden_typ_fg, var_dat_zeit_aenderung;
  END FOR;

  -- 6. Dynamic Merge into Country_2-Specific Table
  SET dynamic_sql = FORMAT("""
    MERGE INTO `dbp_data.wup_stunden_tag_%s` AS tgt
    USING (SELECT CAST(? AS INT64) as wup_id, CAST(? AS INT64) as nb_id, CAST(? AS INT64) as mandant_id, ? as dat) AS src
    ON  tgt.wup_id = src.wup_id AND tgt.nb_id = src.nb_id AND tgt.mandant_id = src.mandant_id AND tgt.dat = src.dat
    WHEN MATCHED THEN
      UPDATE SET stunden_sonstige = CAST(? AS NUMERIC)
    WHEN NOT MATCHED THEN
      INSERT (wup_id, nb_id, mandant_id, dat, stunden_markt, stunden_sonstige, stunden_plan, stunden_co5_sonstige, ums_netto_plan, ums_netto_plan_man, wrg_id)
      VALUES (CAST(? AS INT64), CAST(? AS INT64), CAST(? AS INT64), ?, 0, CAST(? AS NUMERIC), NULL, 0, 0, NULL, ?)
    """, mandant_krz);

  EXECUTE IMMEDIATE dynamic_sql USING 
    wup_id, nb_id, mandant_id, dat,
    var_total_stunden,
    wup_id, nb_id, mandant_id, dat, var_total_stunden, var_wrg_id;

  COMMIT TRANSACTION;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = FORMAT("Error in sp_nettostunden_sonstige: %s", @@error.message);
END;