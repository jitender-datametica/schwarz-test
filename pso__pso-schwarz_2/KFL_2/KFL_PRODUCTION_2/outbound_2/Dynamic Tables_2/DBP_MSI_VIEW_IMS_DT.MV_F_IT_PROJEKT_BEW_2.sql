CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_it_projekt_bew_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_projekt_id AS it_projekt_id,
  dat_leistung AS dat_leistung,
  CASE
    WHEN it_projekt_bereich_id <> ''
    THEN it_projekt_bereich_id
    ELSE SUBSTR(CAST(CAST(hr_objekt_ebene11_id AS BIGNUMERIC) AS STRING), 1, 10)
  END AS it_projekt_bereich_id,
  mandant_id AS mandant_id,
  CASE
    WHEN it_projekt_bereich_id = 'KIS' OR hr_objekt_ebene11_id = 50551504
    THEN 14
    WHEN mandant_id = 1
    THEN 15
    ELSE 16
  END AS berichts_position_it_id,
  it_plan_ebene_id AS it_plan_ebene_id,
  stunden_ist AS stunden_ist,
  stunden_bewertet AS stunden_bewertet
FROM kfl_production_dbp_view.v_it_projekt_bew_2 AS v01
WHERE
  extern_fg = 0;
