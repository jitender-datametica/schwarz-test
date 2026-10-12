CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_zek_1 AS SELECT V1.zek_id,
 V1.mandant_id,
 V2.mandant_kbez,
 V1.wbl_id,
  CASE
  WHEN CAST(ROUND(SAFE_CAST(V1.zek_id AS BIGNUMERIC), 0) AS STRING) <> V1.zek_id
  THEN V1.zek_id
  ELSE TRIM(CAST(ROUND(SAFE_CAST(V1.zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
  END AS zek_id_lang,
 V1.zek_name,
    CASE
    WHEN CAST(ROUND(SAFE_CAST(V1.zek_id AS BIGNUMERIC), 0) AS STRING) <> V1.zek_id
    THEN V1.zek_id
    ELSE TRIM(CAST(ROUND(SAFE_CAST(V1.zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
    END || ' ' || V1.zek_name AS zek_id_lang_name
FROM kfl_production_dbp_view.v_zek_1 AS V1
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V2 ON V1.mandant_id = V2.mandant_id
WHERE V1.zek_id <> '-1';