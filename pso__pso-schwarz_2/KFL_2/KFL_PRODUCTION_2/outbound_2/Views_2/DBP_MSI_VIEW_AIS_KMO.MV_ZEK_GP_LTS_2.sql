CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_zek_gp_lts_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
-- Anpassung bisherige Logik mit FM000 aufgrund Änderung Spalte zek_id zu Textfeld - AP0172759/SPEC0207789 sschuecke 01.09.2023

SELECT mandant_id,
 zek_id,
 wbl_id,
  CASE
  WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
  THEN zek_id
  ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
  END AS zek_id_lang,
  CASE
  WHEN zek_id <> '-1'
  THEN zek_name
  ELSE ' '
  END AS zek_name,
  CASE
  WHEN zek_id <> '-1'
  THEN CASE
     WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
     THEN zek_id
     ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
     END || ' ' || zek_name
  ELSE ' '
  END AS zek_id_lang_name
FROM kfl_production_dbp_view.v_zek_2 AS V01
WHERE mandant_id <> 1;