CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hwg_per_1 (hwg_id, abt_id, arthiertyp_id) AS SELECT DISTINCT
 hwg_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per_1 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = PARSE_DATE('%F', '9999-12-31');