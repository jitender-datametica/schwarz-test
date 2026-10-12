CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_zek_sec_zek_zu (zek_sec_id, mandant_id, zek_id) AS SELECT zek_id
 AS zek_sec_id,
 mandant_id,
 zek_id
FROM kfl_production_dbp_msi_view2.mv_zek
WHERE zek_id <> '-1'
UNION DISTINCT
SELECT '97' AS zek_sec_id,
 mandant_id,
 '97' AS zek_id
FROM kfl_production_dbp_msi_view2.mv_zek
WHERE zek_id <> '-1'
 AND mandant_id = 1;