CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_abt_1 (abt_id, arthiertyp_id) AS SELECT abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1 AS V01
WHERE arthiertyp_id = 2;