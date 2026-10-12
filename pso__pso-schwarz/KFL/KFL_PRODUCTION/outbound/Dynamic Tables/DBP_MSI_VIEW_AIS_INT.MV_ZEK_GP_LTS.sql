CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_zek_gp_lts
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  zek_id AS zek_id,
  wbl_id AS wbl_id,
  CASE
    WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
    THEN zek_id
    ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
  END AS zek_id_lang,
  CASE WHEN zek_id <> '-1' THEN zek_name ELSE ' ' END AS zek_name,
  CASE
    WHEN zek_id <> '-1'
    THEN CASE
      WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
      THEN zek_id
      ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
    END || ' ' || zek_name
    ELSE ' '
  END AS zek_id_lang_name
FROM kfl_production_dbp_view.v_zek AS v01;
