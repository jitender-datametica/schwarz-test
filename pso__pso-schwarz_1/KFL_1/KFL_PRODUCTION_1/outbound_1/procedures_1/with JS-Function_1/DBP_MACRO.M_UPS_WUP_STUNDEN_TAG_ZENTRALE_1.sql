CREATE OR REPLACE PROCEDURE `dbp_macro.m_ups_wup_stunden_tag_zentrale`(
  mandant_id FLOAT64,
  wup_id FLOAT64,
  nb_id FLOAT64,
  dat DATE,
  ums_netto_plan_man FLOAT64,
  stunden_markt FLOAT64,
  stunden_sonstige FLOAT64,
  stunden_versetzung FLOAT64,
  stunden_plan FLOAT64,
  stunden_sonstige_plan FLOAT64,
  sperre_monat FLOAT64,
  sperre_woche FLOAT64
)
BEGIN
  DECLARE sql_stmt STRING;

  -- Start Transaction (mirrors Snowflake COMMIT logic)
  BEGIN TRANSACTION;

  -- Use EXECUTE IMMEDIATE to handle the dynamic MERGE and avoid column ambiguity
  SET sql_stmt = """
    MERGE INTO `dbp_data.wup_stunden_tag_1` AS target
    USING (
      SELECT
        v01.wup_id,
        v01.nb_id,
        v01.mandant_id,
        v01.dat,
        cast(CASE WHEN ? IN (0,1) THEN COALESCE(?, v02.ums_netto_plan_man) ELSE v02.ums_netto_plan_man END as numeric) AS ums_netto_plan_man,
        cast(CASE WHEN ? <> 1 AND ? IN (0,1) THEN COALESCE(?, v02.stunden_markt) ELSE v02.stunden_markt END as numeric) AS stunden_markt,
        cast(CASE WHEN ? IN (0,1) THEN COALESCE(?, v02.stunden_sonstige) ELSE v02.stunden_sonstige END as numeric)  AS stunden_sonstige,
        cast(CASE WHEN ? <> 1 AND ? IN (0,1) THEN COALESCE(?, v02.stunden_versetzung) ELSE v02.stunden_versetzung END as numeric) AS stunden_versetzung,
        cast(CASE WHEN ? IN (0,1) THEN COALESCE(?, v02.stunden_plan) ELSE v02.stunden_plan END as numeric) AS stunden_plan,
        cast(CASE WHEN ? IN (0,1) THEN COALESCE(?, v02.stunden_sonstige_plan) ELSE v02.stunden_sonstige_plan END as numeric) AS stunden_sonstige_plan,
        v03.wrg_id
      FROM (
        SELECT 
          v01_2.wup_id, v01_2.nb_id, v01_2.mandant_id, v01_1.dat
        FROM `dbp_data.tag_1` AS v01_1
        CROSS JOIN `dbp_data.wup_1` AS v01_2
        WHERE v01_2.mandant_id = ?
          AND v01_2.wup_id = ?
          AND v01_2.nb_id = ?
          AND v01_1.dat = ?
      ) AS v01
      LEFT JOIN `dbp_data.wup_stunden_tag_1` AS v02
        ON v01.wup_id = v02.wup_id 
        AND v01.nb_id = v02.nb_id 
        AND v01.mandant_id = v02.mandant_id 
        AND v01.dat = v02.dat
      LEFT JOIN (
        SELECT mandant_id, wrg_id 
        FROM `dbp_data.mandant_wrg_typ_zu_1` 
        WHERE wrg_typ_id = 1
      ) AS v03 ON v01.mandant_id = v03.mandant_id
    ) AS source
    ON target.wup_id = source.wup_id 
      AND target.nb_id = source.nb_id 
      AND target.mandant_id = source.mandant_id 
      AND target.dat = source.dat
    
    WHEN MATCHED THEN UPDATE SET
      target.wrg_id = source.wrg_id,
      target.ums_netto_plan_man = source.ums_netto_plan_man,
      target.stunden_markt = source.stunden_markt,
      target.stunden_sonstige = source.stunden_sonstige,
      target.stunden_versetzung = source.stunden_versetzung,
      target.stunden_plan = source.stunden_plan,
      target.stunden_sonstige_plan = source.stunden_sonstige_plan

    WHEN NOT MATCHED THEN INSERT (
      wup_id, nb_id, mandant_id, dat, wrg_id, 
      ums_netto_plan_man, ums_netto_plan, stunden_markt, 
      stunden_sonstige, stunden_versetzung, stunden_plan, 
      stunden_sonstige_plan, stunden_plan_pep, stunden_co1_iks, 
      stunden_co2_ea, stunden_co3_anue, stunden_co4_reinigung, 
      stunden_co5_sonstige
    )
    VALUES (
      source.wup_id, source.nb_id, source.mandant_id, source.dat, source.wrg_id,
      source.ums_netto_plan_man, 0, source.stunden_markt,
      source.stunden_sonstige, COALESCE(source.stunden_versetzung, 0), source.stunden_plan,
      source.stunden_sonstige_plan, 0, 0, 0, 0, 0, 0
    )
  """;

  -- Execute using the exact order of placeholders (?) in the SQL string
  EXECUTE IMMEDIATE sql_stmt
  USING 
    sperre_woche, ums_netto_plan_man,           -- For ums_netto_plan_man CASE
    mandant_id, sperre_monat, stunden_markt,    -- For stunden_markt CASE
    sperre_monat, stunden_sonstige,             -- For stunden_sonstige CASE
    mandant_id, sperre_monat, stunden_versetzung,-- For stunden_versetzung CASE
    sperre_woche, stunden_plan,                 -- For stunden_plan CASE
    sperre_woche, stunden_sonstige_plan,        -- For stunden_sonstige_plan CASE
    mandant_id, wup_id, nb_id, dat;             -- For the v01 subquery WHERE clause

  COMMIT TRANSACTION;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;