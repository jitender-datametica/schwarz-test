CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_wg_per_1 (wg_id, arthiertyp_id, abt_id, owg_id) AS SELECT
DISTINCT wg_id,
 arthiertyp_id,
 abt_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_1 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = PARSE_DATE('%F', '9999-12-31');