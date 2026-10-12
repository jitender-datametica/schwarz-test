CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_abt_1 AS SELECT DISTINCT abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1
WHERE arthiertyp_id = 2;