CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_zek_1 (mandant_id, zek_id, wbl_id, zek_id_lang, zek_name,
zek_id_lang_name) AS SELECT mandant_id,
 zek_id,
 wbl_id,
  CASE
  WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
  THEN zek_id
  ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
  END AS zek_id_lang,
 zek_name,
    CASE
    WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
    THEN zek_id
    ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
    END || ' ' || zek_name AS zek_id_lang_name
FROM kfl_production_dbp_view.v_zek_1 AS V01;