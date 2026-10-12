CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_zek (zek_id, mandant_id, wbl_id, zek_id_lang, zek_name,
zek_id_lang_name) AS SELECT zek_id,
 mandant_id,
 MAX(wbl_id) AS wbl_id,
 MAX(CASE
   WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
   THEN zek_id
   ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
   END) AS zek_id_lang,
 MAX(zek_name) AS zek_name_,
   MAX(CASE
     WHEN CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING) <> zek_id
     THEN zek_id
     ELSE TRIM(CAST(ROUND(SAFE_CAST(zek_id AS BIGNUMERIC), 0) AS STRING FORMAT '000'))
     END) || ' ' || MAX(zek_name) AS zek_id_lang_name
FROM kfl_production_dbp_view.v_zek
WHERE zek_id <> '-1'
GROUP BY zek_id,
 mandant_id
UNION DISTINCT
SELECT zek_vat_id AS zek_id,
 mandant_id,
 0 AS wbl_id,
 zek_vat_id AS zek_id_lang,
 'system generated, missing in SAP T024' AS zek_name,
 TRIM(zek_vat_id || ' system generated, missing in SAP T024') AS zek_id_lang_name
FROM kfl_production_dbp_view.v_art
WHERE (CAST(mandant_id AS BIGNUMERIC), zek_vat_id) NOT IN (SELECT (mandant_id, zek_id)
   FROM kfl_production_dbp_view.v_zek)
GROUP BY zek_id,
 mandant_id;