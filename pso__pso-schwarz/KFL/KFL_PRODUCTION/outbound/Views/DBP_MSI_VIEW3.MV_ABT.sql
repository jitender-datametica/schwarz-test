CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_abt (mandant_id, abt_id, arthiertyp_id) AS SELECT mandant_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt
WHERE arthiertyp_id = 2;