CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_abt AS SELECT DISTINCT abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt
WHERE arthiertyp_id = 2;