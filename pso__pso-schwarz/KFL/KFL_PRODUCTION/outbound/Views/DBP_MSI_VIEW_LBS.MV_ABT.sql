CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_abt (abt_id, mandant_id, arthiertyp_id) AS SELECT abt_id,
 mandant_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt;